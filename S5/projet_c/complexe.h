#ifndef COMPLEX_H
#define COMPLEX_H

// Type utilisateur complexe_t
struct complexe_t {
    double reelle;
    double imaginaire;
};

typedef struct complexe_t complexe_t;

// Fonctions reelle et imaginaire
/**
 * reelle
 *
 * Renvoie la partie réelle du nombre complexe donné en argument.
 * 
 * Paramètres :
 * c                [in]  Pointeur vers un complexe dont on veut la partie réelle
 * 
 * Pré-conditions : aucune
 * Post-conditions : result = re(complexe)
 * 
 * Retourne: partie réele de c
 */
double reelle(complexe_t c);

/**
 * imaginaire
 *
 * Renvoie la partie imaginaire du nombre complexe donné en argument.
 * 
 * Paramètres :
 * c                [in]  Pointeur vers un complexe dont on veut la partie imaginaire
 * 
 * Pré-conditions : aucune
 * Post-conditions : result = im(complexe)
 * 
 * Retourne: partie imaginaire de c
 */
double imaginaire(complexe_t c);

// Procédures set_reelle, set_imaginaire et init
/**
 * set_reelle
 *
 * Modifie la partie réelle du nombre complexe donné en argument.
 * 
 * Paramètres :
 * c                [in/out]  Pointeur vers un complexe dont on veut modifier la partie réelle
 * reel             [in]      Nouvelle valeur de la partie réelle
 * 
 * Pré-conditions : aucune
 * Post-conditions : reelle(*c) = reel
 */
void set_reelle(complexe_t* c, double reel);

/**
 * set_imaginaire
 *
 * Modifie la partie imaginaire du nombre complexe donné en argument.
 * 
 * Paramètres :
 * c                [in/out]  Pointeur vers un complexe dont on veut modifier la partie imaginaire
 * imaginaire       [in]      Nouvelle valeur de la partie imaginaire
 * 
 * Pré-conditions : aucune
 * Post-conditions : imaginaire(*c) = imaginaire
 */
void set_imaginaire(complexe_t* c, double imaginaire);


/**
 * init
 *
 * Modifie la partie réelle et la partie imaginaire du nombre complexe donné avec les deux réels donnés en arguments.
 * 
 * Paramètres :
 * c                [in/out]  Pointeur vers un complexe
 * reel             [in]      Nouvelle valeur de la partie réelle
 * imaginaire       [in]      Nouvelle valeur de la partie imaginaire
 * 
 * Pré-conditions : aucune
 * Post-conditions : reelle(*c) = reel, imaginaire(*c) = imaginaire
 */
void init(complexe_t* c, double reel, double imaginaire);


// Procédure copie
/**
 * copie
 * Copie les composantes du complexe donné en second argument dans celles du premier
 * argument
 *
 * Paramètres :
 *   resultat       [out] Complexe dans lequel copier les composantes
 *   autre          [in]  Complexe à copier
 *
 * Pré-conditions : resultat non null
 * Post-conditions : resultat et autre ont les mêmes composantes
 */
void copie(complexe_t* resultat, complexe_t autre);

// Algèbre des nombres complexes
/**
 * conjugue
 * Calcule le conjugué du nombre complexe op et le sotocke dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe dont on veut le conjugué
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : reelle(*resultat) = reelle(op), complexe(*resultat) = - complexe(op)
 */
void conjugue(complexe_t* resultat, complexe_t op);

/**
 * ajouter
 * Réalise l'addition des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche + droite
 */
void ajouter(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * soustraire
 * Réalise la soustraction des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche - droite
 */
void soustraire(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * multiplier
 * Réalise le produit des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche * droite
 */
void multiplier(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * echelle
 * Calcule la mise à l'échelle d'un nombre complexe avec le nombre réel donné (multiplication
 * de op par le facteur réel facteur).
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe à mettre à l'échelle
 *   facteur        [in]  Nombre réel à multiplier
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = op * facteur
 */
void echelle(complexe_t* resultat, complexe_t op, double facteur);

/**
 * puissance
 * Calcule la puissance entière du complexe donné et stocke le résultat dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe dont on veut la puissance
 *   exposant       [in]  Exposant de la puissance
 *
 * Pré-conditions : resultat non-null, exposant >= 0
 * Post-conditions : *resultat = op * op * ... * op
 *                                 { n fois }
 */
void puissance(complexe_t* resultat, complexe_t op, int exposant);

// Module et argument
/**
 * module_carre
 *
 * Calcule le module au carré du complexe donné.
 * 
 * Paramètres :
 *   c              [in]  Complexe dont on veut le module au carré
 * 
 * Pré-conditions : aucune
 * Post-conditions : result = |c|^2
 * 
 * Retourne: module au carré de c
 */
double module_carre(complexe_t c);

/**
 * module
 *
 * Calcule le module du complexe donné.
 * 
 * Paramètres :
 *  c              [in]  Complexe dont on veut le module
 * 
 * Pré-conditions : aucune
 * Post-conditions : result = |c|
 * 
 * Retourne: module de c
 */
double module(complexe_t c);

/**
 * argument
 *
 * Calcule l'argument du complexe donné.
 * 
 * Paramètres :
 * c              [in]  Complexe dont on veut l'argument
 * 
 * Pré-conditions : c != 0
 * Post-conditions : result = arg(c)
 * 
 * Retourne: argument de c
 * Erreur : Division par zero si c.reelle = 0
 */
double argument(complexe_t c);


#endif // COMPLEXE_H



