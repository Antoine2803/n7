/** Définition d'un point.
 * @author  Xavier Crégut
 * @composed 1 "" "1 segments" Segments
 */
public class Point {
	private double x;		// abscisse
	private double y;		// ordonnée
	/** @hidden */
	private Segments segments; // les segments dont ce point est extrémité

	/**  Construction d'un point à partir de son abscisse et de son ordonnée.
	  *  @param	x	abscisse
	  *  @param	y	ordonnée */
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
		this.segments = new Segments();
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
		this.segments.majLongueur();
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
	}

	/** Inscrire le segment s auprès du point. */
	//@ requires s != null;
	public void inscrire(Segment s) {
		this.segments.ajouter(s);
	}

	/** Annuler l'inscription d'un segment. */
	public void annuler(Segment s) {
		this.segments.supprimer(s);
	}
}
