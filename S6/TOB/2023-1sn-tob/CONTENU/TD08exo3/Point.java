/** Définition d'un point.
// AUTEUR START DELETE
 * @author  Xavier Crégut
// AUTEUR STOP DELETE
// UMLGRAPH START DELETE
// ATTRIBUT_SEGMENT START DELETE
 * @navassoc 1 "" "1 monSegment" Segment
// ATTRIBUT_SEGMENT STOP DELETE
// UMLGRAPH STOP DELETE
 */
public class Point {
	private double x;		// abscisse
	private double y;		// ordonnée
// NO_INITIALE START DELETE
// ATTRIBUT_SEGMENT START DELETE
// UMLGRAPH START DELETE
	/** @hidden */
// UMLGRAPH STOP DELETE
	private Segment monSegment;	// le segment dont ce point est extrémité
// ATTRIBUT_SEGMENT STOP DELETE
// NO_INITIALE STOP DELETE

	/**  Construction d'un point à partir de son abscisse et de son ordonnée.
	  *  @param	x	abscisse
	  *  @param	y	ordonnée */
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
// NO_INITIALE START DELETE
// NO_INITIALE STOP DELETE
	}

	/** Abscisse du point. */
	public double getX() {
		return this.x;
	}

	/** Ordonnée du point. */
	public double getY() {
		return this.y;
	}

	/** Distance par rapport à un autre point.  */
	public double distance(Point autre) {
		return Math.sqrt(Math.pow(autre.x - this.x, 2)
					+ Math.pow(autre.y - this.y, 2));
	}

   /** Translater le point.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y */
	public void translater(double dx, double dy) {
		this.x += dx;
		this.y += dy;
// NO_INITIALE START DELETE
// ATTRIBUT_SEGMENT START DELETE
		this.monSegment.majLongueur();
// ATTRIBUT_SEGMENT STOP DELETE
// NO_INITIALE STOP DELETE
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
	}
// NO_INITIALE START DELETE

	/** Inscrire le segment s auprès du point. */
	//@ requires s != null;
// ATTRIBUT_SEGMENT START DELETE
	public void inscrire(Segment s) {
		this.monSegment = s;
// ATTRIBUT_SEGMENT STOP DELETE
	}
// NO_INITIALE STOP DELETE
}
