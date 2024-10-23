package menu.commande;

import menu.*;

/** CommandeIrreversible définit une interface pour les commandes
  * qui ne peuvent pas être annulées.  Ceci correspond donc à une
  * interface de marquage.
  * @author	Xavier Crégut
  * @version	1.2
  */
abstract public class CommandeIrreversible implements Commande {

	private Historique historique;

	public CommandeIrreversible(Historique h) {
		this.historique = h;
	}

	// @ensures historique.getNbCommandesExecutees() == 0;
	public final void executer() {
		this.faire();
		historique.vider();
	}

	/** Exécuter effectivement la commande.  */
	//@requires estExecutable();
	abstract protected void faire();

	public Commande copie() {
		return this;
	}

}
