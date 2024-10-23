/** Définition d'un segment.
// AUTEUR START DELETE
 * @author  Xavier Crégut
// AUTEUR STOP DELETE
// UMLGRAPH START DELETE
 * @has * "" "2\nextrémité1, extrémité2" Point
// UMLGRAPH STOP DELETE
 */
public class Segment {
	private Point extremite1;
	private Point extremite2;
	private double longueur;

	/**  Construire un Segment à partir de ses deux points extremité.
	  *  @param ext1	le premier point extrémité
	  *  @param ext2	le deuxième point extrémité */
	public Segment(Point ext1, Point ext2) {
		this.extremite1 = ext1;
		this.extremite2 = ext2;
		this.majLongueur();
// NO_INITIALE START DELETE

		// S'inscrire auprès des points extrémités
		this.extremite1.inscrire(this);
		this.extremite2.inscrire(this);
// NO_INITIALE STOP DELETE
	}

	/** Longueur du segment. */
	public double getLongueur() {
		return this.longueur;
	}

	/** Translater le segment.
	  * @param dx déplacement suivant l'axe des X
	  * @param dy déplacement suivant l'axe des Y */ 
	public void translater(double dx, double dy) {
		this.extremite1.translater(dx, dy);
		this.extremite2.translater(dx, dy);
	}

	/** Afficher le segment. */
	public void afficher() {
		System.out.print("[");
		this.extremite1.afficher();
		System.out.print(";");
		this.extremite2.afficher();
		System.out.print("]");
	}

	/** Mettre à jour la longueur du segment */
	final public void majLongueur() {
// TRACE,majLongueur START DELETE
		// Afficher une trace quand la longueur est recalculée
		System.out.print("majLongueur() sur " + this + " : ");
		this.afficher();
		System.out.println();

// TRACE,majLongueur STOP DELETE
		this.longueur = this.extremite1.distance(this.extremite2);
	}
}
