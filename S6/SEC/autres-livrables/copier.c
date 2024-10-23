#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void err(int retour, char* s_err) {
    if(retour == -1) {
        fprintf(stderr, "Erreur %s", s_err);
        exit(1);
    }
}

int main(int argc, char* argv[]) {
    if(argc != 3){
        printf("Erreur argument programme");
        exit(1);
    } else {
        int fichier_source = open(argv[1], O_RDONLY);
        err(fichier_source, "fichier source");

        int fichier_destination = open(argv[2], O_WRONLY | O_TRUNC | O_CREAT, 0640);
        err(fichier_destination, "fichier destination");

        char buffer[BUFSIZ];
        ssize_t lus;

        while((lus = read(fichier_source, buffer, BUFSIZ)) > 0) {
            ssize_t ecrits = write(fichier_destination, buffer, lus);
        }

        close(fichier_source);
        close(fichier_destination); 
    }

}
