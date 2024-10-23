/** Définition d'un ensemble. */
public interface EnsembleOrdonne<E extends Comparable<E>> extends Ensemble<E> {

	// Caractérisation du min (quand il existe !)
	// ------------------------------------------
	/*@ public invariant ! estVide() ==>
			contient(min());               // un élément de l'ensemble
	@*/

	/**  Obtenir le minimum de l'ensemble.
	 * @return le plus petit élément de l'ensemble  */
	//@ requires !estVide();
	/*@ pure helper @*/ E min();

}
