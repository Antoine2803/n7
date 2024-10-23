#include <stdio.h>  // printf
#include <stdlib.h> // exit
#include <unistd.h> // fork, getpid, getppid
#include <sys/wait.h>

int main(int argc, char *argv[]) {
  int tempsPere, tempsFils;
  pid_t pid_fork;
  int variable = 0;

  tempsPere = 5;
  tempsFils = 8;

  pid_fork = fork();
  // bonne pratique : tester systématiquement le retour des primitives
  if (pid_fork == -1) {
    printf("Erreur fork\n");
    exit(1);
    /* par convention, renvoyer une valeur > 0 en cas d'erreur,
     * différente pour chaque cause d'erreur, ici 1 = erreur fork
     */
  }
  if (pid_fork == 0) { /* fils */
    variable = 10;
    printf("fils: processus %d, de père %d et code du fork %d\n", getpid(),
           getppid(), pid_fork);
    printf("fils: variable = %d\n", variable);
    sleep(tempsFils);
    printf("fin du fils, variable = %d\n", variable);
    exit(EXIT_SUCCESS);
    /* 	bonne pratique :
            terminer les processus par un exit explicite */
  } else { /* père */
    variable = 100;
    printf("père: processus %d, de père %d et code du fork %d\n", getpid(),
           getppid(), pid_fork);
    printf("pere: variable = %d\n", variable);

    // sleep(tempsPere);
    int status;
    if ((pid_fork = wait(&status)) != -1) {
      if (WIFEXITED(status)) {
        printf(" Le processus fils %d s'est terminé avec le code %i \n ",
               pid_fork, WEXITSTATUS(status));
        } else if ( WIFSIGNALED ( status )) {
        printf(" Le processus fils %d s'est terminé par le signal %i \n ",
            pid_fork, WTERMSIG(status));
        }
    }

    printf("fin du père, variable = %d\n", variable);
  }
  return EXIT_SUCCESS; /* -> exit(EXIT_SUCCESS); pour le père */
}
/*
1.1 - 3) au debut on voit que les deux processus sont en S+ puis quand le
fils est fini le fils passe en Z+ 
1.1 - 4) au debut on voit que les deux processus sont en S+ puis quand le
pere termine il disparait et le fils passe en S 

1.2 - les variables sont independantes pour les deux processus

1.3 - 1) Le processus fils 14371 s'est terminé avec le code  0
1.3 - 2) Le processus fils 14657 s'est terminé par le signal 2 
*/
