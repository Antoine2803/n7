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
		this.longueur = extremite1.distance(extremite2);
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
}
