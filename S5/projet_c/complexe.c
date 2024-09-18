#include "complexe.h"
#include <math.h>           // Pour certaines fonctions trigo notamment

// Implantations de reelle et imaginaire
double reelle(complexe_t c){
    return c.reelle;
}


double imaginaire(complexe_t c){
    return c.imaginaire;
}


// Implantations de set_reelle et set_imaginaire
void set_reelle(complexe_t* c, double reel){
    c->reelle = reel;
}


void set_imaginaire(complexe_t* c, double imaginaire){
    c->imaginaire = imaginaire;
}


void init(complexe_t* c, double reel, double imaginaire){
    set_reelle(c, reel);
    set_imaginaire(c, imaginaire);
}


// Implantation de copie
void copie(complexe_t* resultat, complexe_t autre){
    set_reelle(resultat,reelle(autre));
    set_imaginaire(resultat,imaginaire(autre));
}


// Implantations des fonctions algébriques sur les complexes
void conjugue(complexe_t* resultat, complexe_t op){
    set_reelle(resultat,op.reelle);
    set_imaginaire(resultat, -op.imaginaire);
}


void ajouter(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    set_reelle(resultat,gauche.reelle + droite.reelle);
    set_imaginaire(resultat,gauche.imaginaire + droite.imaginaire);
    
}


void soustraire(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    set_reelle(resultat,gauche.reelle - droite.reelle);
    set_imaginaire(resultat,gauche.imaginaire-droite.imaginaire);
}


void multiplier(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    double p_r = gauche.reelle * droite.reelle - gauche.imaginaire * droite.imaginaire;
    double p_i = gauche.imaginaire * droite.reelle + gauche.reelle * droite.imaginaire;
    init(resultat,p_r,p_i);
}


void echelle(complexe_t* resultat, complexe_t op, double facteur){
    set_reelle(resultat,op.reelle * facteur);
    set_imaginaire(resultat,op.imaginaire *facteur);
}


void puissance(complexe_t* resultat, complexe_t op, int exposant){
    init(resultat,1,0);
    for (int i=0;i<exposant;i++){
        multiplier(resultat,*resultat,op);
    }
}


// Implantations du module et de l'argument
double module_carre(complexe_t c){
    return c.reelle*c.reelle + c.imaginaire*c.imaginaire;
}


double module(complexe_t c){
    return sqrt(module_carre(c));
}

double argument(complexe_t c){
    return atan2(c.imaginaire,c.reelle);
}