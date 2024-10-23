#include "listeChaine.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>



liste* creer_liste(){
    liste* res = (liste*)malloc(sizeof(liste));
    res->tete = NULL;
    return res;
}

void detruire_liste(liste** liste_ptr){
    cellule* curseur = (*liste_ptr)->tete;
    cellule* copie = curseur;
    while(curseur != NULL){
        curseur = curseur->suivant;
        free(copie);
        copie = curseur;
    }
    free(*liste_ptr);
    *liste_ptr = NULL;
}

bool est_vide_liste(const liste* liste){
    return liste->tete == NULL;
}

void ajouter_liste(liste* liste, int id, int pid, char* commande, char* etat){
    cellule* curseur = liste->tete;
    if(curseur == NULL){
        cellule* new = (cellule*)malloc(sizeof(cellule));
        new->id = id;
        new->pid = pid;
        new->cmd = (char*)malloc(sizeof(commande));
        stpcpy(new->cmd, commande);
        new->etat = etat;
        new->suivant = NULL;
        liste->tete = new;
    }
    else{
        while(curseur->suivant != NULL){
            curseur = curseur->suivant;
        }
        cellule* new = (cellule*)malloc(sizeof(cellule));
        new->id = id;
        new->pid = pid;
        new->cmd = (char*)malloc(sizeof(commande));
        stpcpy(new->cmd, commande);
        new->etat = etat;
        new->suivant = NULL;
        curseur->suivant = new;
    }
}

void modif_etat_liste(liste* liste, int pid, char* etat){
    cellule* curseur = liste->tete;
    bool sortir = false;
    while(!sortir && curseur != NULL){
        if(curseur->pid == pid){
            curseur->etat = etat;
            sortir = true;
        }
        curseur = curseur->suivant;
    }
}


void supprimer_cmd_liste(liste* liste, int pid){
    cellule* curseur = liste->tete;
    cellule* copie;
    bool sortir = false;
    if (curseur != NULL){
        if(curseur->pid == pid){
            copie = curseur;
            liste->tete = curseur->suivant;
            free(copie->cmd);
            free(copie);
            sortir = true;
        }
        while(!sortir && curseur->suivant != NULL){;
            if(curseur->suivant->pid == pid){
                free(curseur->suivant->cmd);
                curseur->suivant = curseur->suivant->suivant;
                sortir = true;
            }
            curseur = curseur->suivant;
        }
    }
}

void afficher_liste_cmd(liste *liste){
    cellule* curseur = liste->tete;
    if(curseur != NULL){
        while(curseur != NULL){
            printf("commande: %s | etat : %s | id : %d | pid %d\n", curseur->cmd, curseur->etat, curseur->id, curseur->pid);
            curseur = curseur->suivant;
        }
    } else {
        printf("aucune commande en cours\n");
    }
}












