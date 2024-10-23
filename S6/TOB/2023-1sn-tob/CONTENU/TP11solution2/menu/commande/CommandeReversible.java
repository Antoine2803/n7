package menu.commande;

import menu.*;

/** Une commande réversible est une commande qui peut être
  * annulée.  Elle peut être annulée si elle a été exécutée.
  * Elle peut également être refaite.  Une commande ne peut être
  * exécutée qu'une seule fois sinon l'annulation peut ne pas
  * marcher.  Dans ce cas, il faut utiliser copie() pour obtenir
  * une autre commande.
  * @author	Xavier Crégut
  * @version	1.3
  */
abstract public class CommandeReversible implements Commande {

	protected Historique historique;
		// historique où conserver cette commande

	/** Initialiser l'historique dans lequel la commande exécutée doit être
	 * conservée.
	 * @param h historique où conserver cette commande
	 */
	public CommandeReversible(Historique h) {
		this.historique = h;
	}

	// @ensures historique.getNbCommandesExecutees() ==
	//		\old(historique.getNbCommandesExecutees()) + 1;
	public final void executer() {
		this.faire();
		historique.enregistrer(this);
	}

	/** Exécuter effectivement la commande.  */
	//@requires estExecutable();
	abstract protected void faire();

	/** Annuler l'effet de la commande. */
	abstract public void annuler();

	/** Refaire la commande et redonner le résultat de son
	 * exécution initiale.
	 */
	abstract public void refaire();

	public Commande copie() {
		return this;
	}
}
