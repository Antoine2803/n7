/** Modélisation d'une banque.
 * C'est en fait une modélisation très limitée d'une banque en se
 * limitant qu'à quelques opérations.  Ceci permet de démontrer
 * que dans une approche objet, il n'y a pas de classe racine et
 * que le système peut toujours être étendu en ajoutant de
 * nouvelles classes.
 * @author  Xavier Crégut
 */
public class Banque {

	//  Les comptes sont conservés dans un tableau.  On supposera que la
	//  capacité du tableau est suffisante.  Nous ne testerons donc pas
	//  les risques de débordement.
	//
	//  <b>Remarque :</b> Il serait possible d'utiliser la classe
	//  java.util.Vector pour avoir des << tableaux >> redimensionnables.
	//  Dans ce cas, l'attribut nbComptes devient inutile et correspond à
	//  comptes.size().  Cependant, dans le cas présent, ce serait moins
	//  pédagogique puisqu'il faudrait systèmatiquement faire un
	//  transtypage lorsqu'on récupère un compte du vecteur !

	private CompteSimple[] comptes;	// les comptes gérés par la banque
	private int nbComptes;		// le nombre de comptes ouverts

	/** Construire une nouvelle banque sans clients, donc sans comptes. */
	public Banque(int taille) {
		comptes = new CompteSimple[taille];
		nbComptes = 0;
	}

	/** Ouvrir un compte courant pour le client p
	 *  avec un dépot initial « apport ».
	 */
	public void ouvrirCompteCourant(Personne p, double apport) {
		this.comptes[this.nbComptes++] = new CompteCourant(p, apport);
	}

	/** Ouvrir un compte simple pour le client p
	 *  avec un dépot initial « apport ».
	 */
	public void ouvrirCompteSimple(Personne p, double apport) {
		this.comptes[this.nbComptes++] = new CompteSimple(p, apport);
	}

	/** Afficher tous les comptes. */
	public void lister() {
		for (int i = 0; i < nbComptes; i++) {
			System.out.println(comptes[i]);
			System.out.println();
		}
	}

	/** Cumul du solde des comptes gérés par la banque. */
	public double getCumulSoldes() {
		double result = 0;
		for (int i = 0; i < nbComptes; i++) {
			result += comptes[i].getSolde();
		}
		return result;
	}

	/** Prélèvement des frais bancaires : prélèvement de 2 euros sur chaque
	  * compte.
	  */
	public void preleverFrais() {
		for (int i = 0; i < nbComptes; i++) {
			comptes[i].debiter(2);
		}
	}

	/** éditer le relevés des comptes courants */
	public void editerReleves() {
		for (int i = 0; i < nbComptes; i++) {
			if (comptes[i] instanceof CompteCourant) {
				CompteCourant cc = (CompteCourant) comptes[i];
				cc.editerReleve();
			}
		}
	}

}
