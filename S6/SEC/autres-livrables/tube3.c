#include <bits/types/sigset_t.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(){
    int p[2];
    if (pipe(p) == -1) {
        printf("erreur pipe");
        exit(2);
    }

    int pid = fork();
    if (pid == -1){
        printf("erreur fork");
        exit(3);
    }
    else if (pid == 0) {
        int nlus = 1;
        char buff[BUFSIZ];
        close(p[1]);
        while(nlus > 0) {
            nlus = read(p[0], buff, 1);
            printf("lu = %s; nlus = %d\n", buff, nlus);
            sleep(1);
        }
        printf("Sortie de boucle\n");
        exit(EXIT_SUCCESS);
    }
    else {
        close(p[0]);
        int i = 0;
        char* to_write = "1";
        while (i < 3) {
            write(p[1], to_write, strlen(to_write));
            sleep(1);  
            i++;   
        }    
        close(p[1]);
        pause(); //le pause ignore sigchild donc on reste bloque a l'infini => soit faire un traitant pour sigchild soit envoyer un autre signal au pere
    }

    return 0;
}