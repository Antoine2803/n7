package editeur;

/**
  * Réalisation de Ligne en choisissant un tableau pour stocker les caractères
  * de la ligne.
  *
  * @author	Xavier Crégut <Prenom.Nom@enseeiht.fr>
  */

public class LigneTab implements Ligne {
	//@ // Invariants de liaison
	//@ private invariant getLongueur() == longueur;
	//@ private invariant getCurseur() == curseur;
	//@ private invariant (\forall int i; 1 <= i && i <= longueur;
	//@ 		ieme(i) == caracteres[i-1]);
	private char[] caracteres;	// les caractères de la ligne
	private int longueur;		// nombre de caractères de la ligne
	private int curseur;		// position du curseur sur la ligne (1 au début)

	/** Initialiser la ligne à vide avec la capacité indiquée.
	 * @param capacite capacité initiale de la ligne
	 */
	public LigneTab(int capacite) {
		this.caracteres = new char[capacite];
		this.curseur = this.longueur = 0;
	}

	public int getLongueur() {
		return this.longueur;
	}

	public int getCurseur() {
		return this.curseur;
	}

	public char ieme(int i) {
		return this.caracteres[i - 1];
	}

	public char getCourant() {
		return this.caracteres[this.curseur - 1];
	}

	public void avancer() {
		this.curseur++;
	}


	public void reculer() {
		this.curseur--;
	}


	public void raz() {
		this.curseur = 1;
	}


	public void remplacer(char c) {
		this.caracteres[this.curseur - 1] = c;
	}

	public void afficher() {
		if (this.longueur == 0) {
			System.out.print("~");
		} else {
			// Afficher les caractères avant le curseur
			for (int i = 0; i < this.curseur - 1; i++) {
				System.out.print(this.caracteres[i]);
			}

			// Afficher le caractère sous le curseur
			System.out.print("" + '[' + this.caracteres[this.curseur-1] + ']');

			// Afficher les caractères après le curseur
			for (int i = curseur; i < this.longueur; i++) {
				System.out.print(this.caracteres[i]);
			}
		}
		System.out.println();
	}

	/** TODO
	 * Décaler à gauche les éléments à partir de l'indice 'debut' inclu.
	 */
	private void decalerGauche(int debut) {
		for (int i = debut; i < this.longueur; i++) {
			this.caracteres[i - 1] = this.caracteres[i];
		}
	}

	/** TODO
	 * Décaler à droite les éléments à partir de l'indice 'debut' inclu.
	 */
	private void decalerDroite(int debut) {
		for (int i = this.longueur; i > debut; i--) {
			this.caracteres[i] = this.caracteres[i - 1];
		}
	}

	private void garantirNonPlein() {
		if (this.longueur >= this.caracteres.length) { // plus de place
			this.caracteres = java.util.Arrays.copyOf(this.caracteres, this.caracteres.length + 4);
				// XXX : 4 arbitraire
				// XXX : faire une constante !
		}
	}

	public void supprimer() {
		this.decalerGauche(this.curseur);
		this.longueur--;
		this.curseur = Math.min(this.longueur, this.curseur);
	}



	public void ajouterAvant(char c) {
		garantirNonPlein();
		this.decalerDroite(this.curseur);
		this.longueur++;
		this.curseur++;
		this.caracteres[this.curseur] = c;
	}


	public void ajouterApres(char c) {
		garantirNonPlein();
		this.decalerDroite(this.curseur + 1);
		this.longueur++;
		this.caracteres[this.curseur] = c;
		this.curseur++;
	}


	public void ajouterFin(char c) {
		garantirNonPlein();
		this.caracteres[this.longueur] = c;
		this.longueur++;
		this.curseur = Math.max(1, this.curseur);
	}


	public void ajouterDebut(char c) {
		garantirNonPlein();
		this.decalerDroite(0);
		this.longueur++;
		this.curseur++;
		this.caracteres[0] = c;
	}


	public void supprimerPremier() {
		this.decalerDroite(1);
		this.longueur--;
		this.curseur--;
	}


	public void supprimerDernier() {
		this.longueur--;
		this.curseur = Math.min(this.longueur, this.curseur);
	}


}
