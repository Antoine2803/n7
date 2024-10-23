#include "readcmd.h"
#include "listeChaine.h"
#include <bits/types/sigset_t.h>
#include <fcntl.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/* Permet de tester si l'on a une erreur et d'afficher le message s_err */
void err(int retour, char* s_err) {
    if(retour == -1) {
        fprintf(stderr, "Erreur: %s", s_err);
        exit(1);
    }
}

/* numero du procesus en avant plan */
int proc_avant_plan = 0;

/* Tableau des commandes en cours d'execution */
liste* tab_cmd_running;

/* id de la commande du minishell */
int id = 1;

void traitement_SIGCHLD(void){
    int status;
    pid_t pid;
    do {
        pid = waitpid(-1, &status, WNOHANG | WUNTRACED | WCONTINUED);

        if (pid == proc_avant_plan){
            proc_avant_plan = 0;
        }

        if (pid > 0){
            if(WIFEXITED(status)){
                printf("Le processus %d s'est terminé correctement avec le signal %d\n", pid, WEXITSTATUS(status));
                supprimer_cmd_liste(tab_cmd_running, pid);
            } else if (WIFCONTINUED(status)) {
                printf("Le processus %d a repris\n", pid);
                modif_etat_liste(tab_cmd_running, pid, "actif");
            } else if (WIFSIGNALED(status)) {
                printf("Le processus %d a recu le signal %d\n", pid, WTERMSIG(status));
                supprimer_cmd_liste(tab_cmd_running, pid);
            } else if (WIFSTOPPED(status)) {
                printf("Le processus %d a été stoppé par le signal %d\n", pid, WSTOPSIG(status));
                modif_etat_liste(tab_cmd_running, pid, "suspendu");
            }
        }
    } while(pid > 0);
}

void Affiche_prompt(void){
    printf("> ");
}

void sigaction_SIGCHLD(){
        //creation du traitement de SIGCHLD
        struct sigaction action ;
        action.sa_handler = (__sighandler_t) traitement_SIGCHLD;
        sigemptyset (&action.sa_mask ) ;
        action.sa_flags = SA_RESTART;
        sigaction(SIGCHLD, &action, NULL);
}

/* Version 1 qui ignore les signaux */
void create_sigaction(int sig, __sighandler_t handler){
    //creation du traitement de sig avec handler pour traitement
    struct sigaction action ;
    action.sa_handler = (__sighandler_t) handler;
    sigemptyset (&action.sa_mask ) ;
    action.sa_flags = SA_RESTART;
    sigaction(sig, &action, NULL);
}


/* Version 2 masquage */
void masquer_SIGINT_SIGTSTP(){
    //Masque les signaux SIGINT et SIGTSTP
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    sigaddset(&set, SIGTSTP);
    sigprocmask(SIG_SETMASK, &set, NULL);
}

void demasquer_SIGINT_SIGTSTP(){
    //Demasque les signaux SIGINT et SIGTSTP
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    sigaddset(&set, SIGTSTP);
    sigprocmask(SIG_UNBLOCK, &set, NULL);
}

void associer_in_out(char* in, char* out, int* pipeR, int* pipeW) {
    /* associe l'entree standart à in si non null 
     * et la sortie standard à out si non null.
     * Associe aussi les pipes a l'entree et sortie
     * standart selon les mêmes critères
     */
    int retour;
    if (in != NULL) {
        retour = open(in, O_RDONLY);
        err(retour, "Fichier in invalide");
        err(dup2(retour, 0), "dup2");
        close(retour);
    }
    if (out != NULL) {
        retour = open(out, O_WRONLY | O_TRUNC | O_CREAT, 0640);
        err(retour, "Fichier out invalide");
        err(dup2(retour, 1), "dup2");
        close(retour);
    }
    if (pipeW != NULL){
        // pipe to write
        err(dup2(*pipeW, 1), "dup2");
    }
    if (pipeR != NULL){
        // pipe to read
        err(dup2(*pipeR, 0), "dup2");
    }
}

void lancer_cmd(char **cmd, bool background, char* in, char* out, int* pipeR, int* pipeW) {
    /* lance la commande cmd en background si background,
     * associe l'entree standart à in si non null 
     * et la sortie standard à out si non null
     */
    pid_t retour = fork();
    if (retour == -1) {
        printf("Erreur fork\n");
        exit(1);
    } else {
        if (retour == 0) {

            //Pour la version 3 on démasque 
            demasquer_SIGINT_SIGTSTP();
            
            if(!background){ 
                /* Version 1 qui ignore les signaux
                * create_sigaction(SIGTSTP, SIG_DFL);
                * create_sigaction(SIGINT, SIG_DFL);
                */

                /* Version 2 masquage
                demasquer_SIGINT_SIGTSTP();
                */    
            } else {
                /* Version 3 changement de groupe des precessus en arriere plan */
                setpgid(0,0);
            }

            associer_in_out(in, out, pipeR, pipeW);

            execvp(cmd[0], cmd);

            printf("Erreur lors de l'execution de la commande\n");
            exit(EXIT_FAILURE);

        } else {
            ajouter_liste(tab_cmd_running, id, retour, cmd[0], "actif");
            id++;
            if(!background){
                proc_avant_plan = retour;
                //Tant qu'un processus est en avant plan on attend qu'il se termine
                while(proc_avant_plan > 0){
                    pause();
                }
            }
        }
    }
}

void lancer_multi_cmd(char **cmd, bool background, char* in, char* out, int* Npipe, int* pipe_copy, bool first_cmd, bool last_cmd) {
    if (first_cmd && last_cmd) {
        //Si on a qu'une seule commande, on la lance de manière classique
        lancer_cmd(cmd, background, in, out, NULL, NULL);
    } else if (first_cmd) {
        //Si c'est la premiere commande de la sequence, on recupère ce qu'il y a dans le ficher in
        //et on met le résultat dans le pipe
        lancer_cmd(cmd, background, in, NULL, NULL, &Npipe[1]);
    } else if (last_cmd) {
        //Si on est la derniere commande de la sequence, on ferme le pipe en écriture, on lit le pipe et on ecrit
        //dans le fichier out
        close(pipe_copy[1]);
        lancer_cmd(cmd, background, NULL, out, &pipe_copy[0], NULL);
    } else {
        //Si on est une commande au milieu de la sequence on ferme l'ecriture du pipe de la cmd precedente et on ecrit 
        //dans le pipe
        close(pipe_copy[1]);
        lancer_cmd(cmd, background, NULL, NULL, &pipe_copy[0], &Npipe[1]);
    }

}

int main(void) {
    bool fini = false;

    tab_cmd_running = creer_liste();

    sigaction_SIGCHLD();

    /* Version 1 qui ignore les signaux
    * create_sigaction(SIGTSTP, SIG_IGN);
    * create_sigaction(SIGINT, SIG_IGN);
    */

    /* Version 2 masquage / Version 3*/
    masquer_SIGINT_SIGTSTP();

    while (!fini) {
        Affiche_prompt();
        struct cmdline *commande = readcmd();

        if (commande == NULL) {
            // commande == NULL -> erreur readcmd()
            perror("erreur lecture commande \n");
            exit(EXIT_FAILURE);

        } else {

            if (commande->err) {
                // commande->err != NULL -> commande->seq == NULL
                printf("erreur saisie de la commande : %s\n", commande->err);

            } else {
                //Creation du pipe
                int p_fisrt[2]; 
                err(pipe(p_fisrt), "Erreur pipe");
                
                int p_copy[2];
                int indexseq = 0;
                char **cmd;
                while ((cmd = commande->seq[indexseq])) {
                    //on copie le pipe
                    p_copy[0] = p_fisrt[0];
                    p_copy[1] = p_fisrt[1];
                    //on cree un nouveau pipe
                    err(pipe(p_fisrt), "Erreur pipe");

                    bool first_cmd = indexseq == 0;
                    bool last_cmd = commande->seq[indexseq+1] == NULL;
                    if (cmd[0]) {
                        if (strcmp(cmd[0], "exit") == 0) {
                            fini = true;
                            printf("Au revoir ...\n");
                        }else if (strcmp(cmd[0], "lj") == 0){
                            afficher_liste_cmd(tab_cmd_running);
                        } else {
                            lancer_multi_cmd(cmd, commande->backgrounded, commande->in, commande->out, p_fisrt, p_copy, first_cmd, last_cmd);
                        }
                        indexseq++;
                    }
                }

            }
        }
    }
    return EXIT_SUCCESS;
}
