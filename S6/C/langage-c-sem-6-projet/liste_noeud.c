#define _GNU_SOURCE
#include "liste_noeud.h"
#include <stdlib.h>
#include <math.h>

struct cellule{
    struct cellule* suivant;
    float dist;
    noeud_id_t noeud;
    noeud_id_t precedent;
};

struct liste_noeud_t{
    cellule* tete;
};

liste_noeud_t* creer_liste(){
    liste_noeud_t* res = (liste_noeud_t*)malloc(sizeof(liste_noeud_t));
    res->tete = NULL;
    return res;
}

void detruire_liste(liste_noeud_t** liste_ptr){
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

bool est_vide_liste(const liste_noeud_t* liste){
    return liste->tete == NULL;
}

bool contient_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud){
    cellule* curseur = liste->tete;
    while(curseur != NULL){
        if(curseur->noeud == noeud){
            return true;
        }
        curseur = curseur->suivant;
    }
    return false;
}

bool contient_arrete_liste(const liste_noeud_t* liste, noeud_id_t source, noeud_id_t destination){
    cellule* curseur = liste->tete;
    while(curseur != NULL){
        if(curseur->noeud == destination && curseur->precedent == source){
            return true;
        }
        curseur = curseur->suivant;
    }
    return false;
}

float distance_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud){
    cellule* curseur = liste->tete;
    while(curseur != NULL){
        if(curseur->noeud == noeud){
            return curseur->dist;
        }
        curseur = curseur->suivant;
    }
    return INFINITY;
}

noeud_id_t precedent_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud){
    cellule* curseur = liste->tete;
    while(curseur != NULL){
        if(curseur->noeud == noeud){
            return curseur->precedent;
        }
        curseur = curseur->suivant;
    }
    return NO_ID;
}

noeud_id_t min_noeud_liste(const liste_noeud_t* liste){
    cellule* curseur = liste->tete;
    if(curseur == NULL){
        return NO_ID;
    }
    else {
        noeud_id_t min = liste->tete->noeud; 
        float dist_min = liste->tete->dist;
        while(curseur != NULL){
            if(dist_min > curseur->dist){
                min = curseur->noeud;
                dist_min = curseur->dist;
            }
            curseur = curseur->suivant;
        }
        return min;
    }
}

void inserer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud, noeud_id_t prec, float dist){
    cellule* curseur = liste->tete;
    if(curseur == NULL){
        cellule* new = (cellule*)malloc(sizeof(cellule));
        new->noeud = noeud;
        new->dist = dist;
        new->precedent = prec;
        new->suivant = NULL;
        liste->tete = new;
    }
    else{
        while(curseur->suivant != NULL){
            curseur = curseur->suivant;
        }
        cellule* new = (cellule*)malloc(sizeof(cellule));
        new->noeud = noeud;
        new->dist = dist;
        new->precedent = prec;
        new->suivant = NULL;
        curseur->suivant = new;
    }
}

void changer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud, noeud_id_t prec, float dist){
    cellule* curseur = liste->tete;
    bool modifie = false;
    while(curseur != NULL && !modifie){
        if(curseur->noeud == noeud){
            curseur->dist = dist;
            curseur->precedent = prec;
            modifie = true;
        }
        curseur = curseur->suivant;
    }
    if(!modifie){
         inserer_noeud_liste(liste, noeud, prec, dist);
    }
}

void supprimer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud){
    cellule* curseur = liste->tete;
    cellule* copie;
    bool sortir = false;
    if (curseur != NULL){
        if(curseur->noeud == noeud){
            copie = curseur;
            liste->tete = curseur->suivant;
            free(copie);
            sortir = true;
        }
        while(!sortir && curseur->suivant != NULL){;
            if(curseur->suivant->noeud == noeud){
                curseur->suivant = curseur->suivant->suivant;
                sortir = true;
            }
            curseur = curseur->suivant;
        }
    }
}












