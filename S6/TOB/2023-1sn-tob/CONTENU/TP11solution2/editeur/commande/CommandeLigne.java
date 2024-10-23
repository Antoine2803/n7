package editeur.commande;

import editeur.Ligne;
import menu.Commande;
import menu.commande.CommandeReversible;
import menu.Historique;


/** Une CommandeLigne est une commande qui travaille sur une
 * ligne de l'éditeur orienté ligne.
 * @author	Xavier Crégut
 * @version	1.4
 */
abstract public class CommandeLigne
	extends CommandeReversible
{
	/** La ligne manipulée par la commande. */
	protected Ligne ligne;

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeLigne(Ligne l, Historique h) {
		super(h);
		ligne = l;
	}

	// executer() consiste à mémoriser les informations
	// nécessaires pour annuler ou refaire(), puis à faire la
	// commande,  donc à la refaire() !
	final protected void faire() {
		memoriser();
		refaire();
	}

	/** Mémoriser les informations nécessaires pour annuler ou
	  * refaire la commande.
	  */
	abstract protected void memoriser();

}
