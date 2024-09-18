#include "dijkstra.h"
#include <stdlib.h>

/**
 * construire_chemin_vers - Construit le chemin depuis le noeud de départ donné vers le
 * noeud donné. On passe un chemin en entrée-sortie de la fonction, qui est mis à jour
 * par celle-ci.
 *
 * Le noeud de départ est caractérisé par un prédécesseur qui vaut `NO_ID`.
 *
 * Ce sous-programme fonctionne récursivement :
 *  1. Si le noeud a pour précédent `NO_ID`, on a fini (c'est le noeud de départ, le chemin de
 *     départ à départ se compose du simple noeud départ)
 *  2. Sinon, on construit le chemin du départ au noeud précédent (appel récursif)
 *  3. Dans tous les cas, on ajoute le noeud au chemin, avec les caractéristiques associées dans visites
 *
 * @param chemin [in/out] chemin dans lequel enregistrer les étapes depuis le départ vers noeud
 * @param visites [in] liste des noeuds visités créée par l'algorithme de Dijkstra
 * @param noeud noeud vers lequel on veut construire le chemin depuis le départ
 */
void construire_chemin_vers(liste_noeud_t* liste, noeud_id_t destination, liste_noeud_t** chemin){
    noeud_id_t np = precedent_noeud_liste(liste, destination); 
    if (np == NO_ID){
        inserer_noeud_liste(*chemin, destination, np, 0.0);
    } else {
        construire_chemin_vers(liste, np, chemin);
        inserer_noeud_liste(*chemin, destination, np, distance_noeud_liste(liste, np));
    }
}


float dijkstra(
    const struct graphe_t* graphe, 
    noeud_id_t source, noeud_id_t destination, 
    liste_noeud_t** chemin) {
    liste_noeud_t* AVisiter = creer_liste();
    liste_noeud_t* Visite = creer_liste();
    inserer_noeud_liste(AVisiter, source, NO_ID, 0.0);
    noeud_id_t nc = NO_ID;
    while(!est_vide_liste(AVisiter)){
        nc = min_noeud_liste(AVisiter);
        inserer_noeud_liste(Visite, nc, precedent_noeud_liste(AVisiter, nc), distance_noeud_liste(AVisiter, nc));
        supprimer_noeud_liste(AVisiter, nc);
        int n = nombre_voisins(graphe, nc);
        noeud_id_t* voisin = (noeud_id_t*)malloc(sizeof(noeud_id_t)*n);
        noeuds_voisins(graphe, nc, voisin);
        for(int i = 0; i<n; i++){
            float deltap = distance_noeud_liste(Visite, nc) + noeud_distance(graphe, nc, voisin[i]);
            if(deltap < distance_noeud_liste(AVisiter, voisin[i])){
                changer_noeud_liste(AVisiter, voisin[i], nc, deltap);
            }
        } 
        free(voisin); 
    }
    if(chemin != NULL){
        (*chemin) = creer_liste();
        construire_chemin_vers(Visite, destination, chemin);
    }
    detruire_liste(&AVisiter);
    float res = distance_noeud_liste(Visite, destination);
    detruire_liste(&Visite);
    return res;
}



