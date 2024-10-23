/** Définition d'un segment.
 * @author  Xavier Crégut
 * @has * "" "2\nextrémité1, extrémité2" Point
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

		// S'inscrire auprès des points extrémités
		this.extremite1.inscrire(this);
		this.extremite2.inscrire(this);
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
		// Afficher une trace quand la longueur est recalculée
		System.out.print("majLongueur() sur " + this + " : ");
		this.afficher();
		System.out.println();

		this.longueur = this.extremite1.distance(this.extremite2);
	}

	/** Détruire le segment (destructeur). */
	public void detruire() {
		this.extremite1.annuler(this);
		this.extremite2.annuler(this);
	}
}
