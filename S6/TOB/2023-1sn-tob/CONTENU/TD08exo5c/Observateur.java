/** Un observateur est un objet qui souhaite être averti par la source auprès
 * de laquelle il s'inscrit.
 * @author	Xavier Crégut
 */
interface Observateur {

	/** Mettre à jour l'observateur.  Cette méthode est appelée chaque fois
	  * que l'objet observé change.
	  */
	void maj();
}
