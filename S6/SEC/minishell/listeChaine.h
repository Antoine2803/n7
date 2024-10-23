#include <stdbool.h>

struct cellule{
    struct cellule* suivant;
    int id;
    int pid;
    char* cmd;
    char* etat;
};

typedef struct cellule cellule;

struct liste{
    cellule* tete;
};

typedef struct liste liste;


liste* creer_liste();

void detruire_liste(liste** liste_ptr);

bool est_vide_liste(const liste* liste);

void ajouter_liste(liste* liste, int id, int pid, char* commande, char* etat);

void modif_etat_liste(liste* liste, int pid, char* etat);

void supprimer_cmd_liste(liste* liste, int pid);

void afficher_liste_cmd(liste* liste);



