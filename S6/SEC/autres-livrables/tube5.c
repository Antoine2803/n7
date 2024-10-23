#include <bits/types/sigset_t.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(){
    int N = 10;
    char tab[N];
    for(int i = 0; i < N; i++) {
        tab[i] = (char) i;
    }

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

        pause();
        char buff[N*10];
        close(p[1]);
        read(p[0], buff, N*10);
        printf("%s\n", buff);
    }
    else {
        close(p[0]);
        while (1) {
            int res = write(p[1], tab, N);
            sleep(1);        
            printf("%d\n", res);
        }    
    }

    return 0;
}