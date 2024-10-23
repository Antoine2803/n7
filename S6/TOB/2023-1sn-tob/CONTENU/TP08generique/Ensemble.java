/** Définition d'un ensemble. */
public interface Ensemble<E> {
	//@ public invariant estVide() <==> cardinal() == 0;
	//@ public invariant 0 <= cardinal();

	/** Obtenir le nombre d'éléments dans l'ensemble.
	 * @return nombre d'éléments dans l'ensemble.  */
	/*@ pure helper @*/ int cardinal();

	/** Savoir si l'ensemble est vide.
	 * @return Est-ce que l'ensemble est vide ? */
	/*@ pure helper @*/ boolean estVide();

	/** Savoir si un élément est présent dans l'ensemble.
	 * @param x l'élément cherché
	 * @return x est dans l'ensemble */
	/*@ pure helper @*/ boolean contient(E x);

	/** Ajouter un élément dans l'ensemble.
	 * @param x l'élément à ajouter */
	//@ ensures contient(x);        // élément ajouté
	//@ ensures ! \old(contient(x)) ==> cardinal() == \old(cardinal()) + 1;	// cardianalité augmentée
	//@ ensures \old(contient(x)) ==> cardinal() == \old(cardinal());		// ou cardinalité inchangée
	void ajouter(E x);

	/** Enlever un élément de l'ensemble.
	  * @param x l'élément à supprimer */
	//@ ensures ! contient(x);      // élément supprimé
	//@ ensures \old(contient(x)) ==> cardinal() == \old(cardinal()) - 1;	// cardinalité diminuée
	//@ ensures ! \old(contient(x)) ==> cardinal() == \old(cardinal());		// ou cardinalité inchangée
	void supprimer(E x);

}
