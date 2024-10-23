/** Définition d'un point.
 * @author  Xavier Crégut
 */
public class Point {
	private double x;		// abscisse
	private double y;		// ordonnée

	/**  Construction d'un point à partir de son abscisse et de son ordonnée.
	  *  @param	x	abscisse
	  *  @param	y	ordonnée */
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
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
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
	}
}
