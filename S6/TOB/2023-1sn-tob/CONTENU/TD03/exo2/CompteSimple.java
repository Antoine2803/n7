/** CompteSimple modélise un compte bancaire simple tenu en euros.
 * Il est caractérisé par un titulaire et un solde (positif ou négatif)
 * et peut être crédité ou débité d'un certain montant.
 * @author	Xavier Crégut
 */
public class CompteSimple {
	//@ public invariant getTitulaire() != null;
	//@ private invariant titulaire == getTitulaire();
	//@ private invariant solde == getSolde();

	/** Titulaire du compte. */
	private Personne titulaire;

	/** Solde du compte exprimé en euros. */
	private double solde;

	/** Initialiser un compte.
	 * @param titulaire le titulaire du compte
	 * @param depotInitial le montant initial du compte
	 */
	//@ requires leTitulaire != null;	// le titulaire existe
	//@ requires depotInitial >= 0;	// montant initial strictement positif
	//@ ensures getSolde() == depotInitial;	// solde initialisé
	//@ ensures getTitulaire() == leTitulaire;	// titulaire initialisé
	public CompteSimple(Personne leTitulaire, double depotInitial) {
		this.solde = depotInitial;
		this.titulaire = leTitulaire;
	}

	/** Initialiser un compte.
	 * Son solde est nul.
	 * @param titulaire le titulaire du compte
	 */
	//@ requires titulaire != null;		// le titulaire existe
	//@ ensures getSolde() == 0;		// pas de dépôt initial
	//@ ensures getTitulaire() == titulaire;	// titulaire initialisé
	public CompteSimple(Personne titulaire) {
		this(titulaire, 0);
	}

	/** Solde du compte exprimé en euros. */
	public /*@ pure @*/ double getSolde() {
		return this.solde;
	}

	/** Titulaire du compte. */
	public /*@ pure @*/ Personne getTitulaire() {
		return this.titulaire;
	}

	/** Créditer le compte du montant (exprimé en euros).
	 * @param montant montant déposé sur le compte en euros
	 */
	//@ requires montant > 0;
	//@ ensures getSolde() == \old(getSolde()) + montant; // montant crédité
	public void crediter(double montant) {
		this.solde = this.solde + montant;
	}

	/** Débiter le compte du montant (exprimé en euros).
	 * @param montant montant retiré du compte en euros
	 */
	//@ requires montant > 0;
	//@ ensures getSolde() == \old(getSolde()) - montant; // montant débité
	public void debiter(double montant) {
		this.solde = this.solde - montant;
	}

	public String toString() {
		return "solde=" + this.solde + ", titulaire=\"" + this.titulaire + "\"";
	}

}
