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
        char buff[BUFSIZ];
        close(p[1]);
        while(1) {
            read(p[0], buff, BUFSIZ);
            printf("%s\n", buff);
            sleep(5);
        }
    }
    else {
        close(p[0]);
        char* to_write = "5";
        while (1) {
            write(p[1], to_write, strlen(to_write));
            sleep(5);        
        }    
    }

    return 0;
}