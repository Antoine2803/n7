/** Définition d'un point mathématique dans un plan qui peut être
  * considéré dans un repère cartésien ou polaire.  Un point peut être affiché,
  * translaté.  Sa distance par rapport à un autre point peut être obtenue.
  * @author	Xavier Crégut <nom@n7.fr>
  */
public class Point {

	private double x;		// abscisse de ce point
	private double y;		// ordonnée de ce point

	/**  Construire un point à partir de son abscisse et de son ordonnée.
	  *  @param	vx	valeur de l'abscisse
	  *  @param	vy	valeur de l'ordonnée
	  */
	public Point(double vx, double vy) {
		this.x = vx;
		this.y = vy;
	}

	/** Obtenir un point à partir de ses données cartésiennes.
	 * @param x l'abscisse du point à créer
	 * @param y l'ordonnée du point à créer
	 * @return le point d'abscisse x et d'ordonnée y
	 */
	public static Point cartesien(double x, double y) {
		return new Point(x, y);
	}

	/** Obtenir un point à partir de ses données polaires.
	 * @param module le module du point à créer
	 * @param argument l'argument du point à créer
	 * @return le point avec le module et l'argument précisés
	 */
	public static Point polaire(double module, double argument) {
		double x = module * Math.cos(argument);
		double y = module * Math.sin(argument);
		return Point.cartesien(x, y);
	}

	/** Changer l'abscisse de ce point.
	  * @param vx	la nouvelle valeur de l'abscisse
	  */
	public void setX(double vx) {
		this.x = vx;
	}

	/** Changer l'ordonnée de ce point.
	  * @param vy	la nouvelle valeur de l'ordonnée
	  */
	public void setY(double vy) {
		this.y = vy;
	}

	/** Obtenir l'abscisse de ce point.
	  * @return abscisse de ce point
	  */
	public double getX() {
		return this.x;
	}

	/** Obtenir l'ordonnée de ce point.
	  * @return ordonnée de ce point
	  */
	public double getY() {
		return this.y;
	}

	/** Obtenir le module de ce point.
	  * @return module de ce point
	  */
	public double getModule() {
		return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
	}

	/** Obtenir l'argument de ce point.
	  * @return l'argument de ce point
	  */
	public double getArgument() {
		return Math.atan2(this.y, this.x);
	}

	/** Changer le module de ce point.
	  * @param nouveau_module la nouvelle valeur du module
	  */
	public void setModule(double nouveau_module) {
		double ancien_argument = this.getArgument();
		this.setX(nouveau_module * Math.cos(ancien_argument));
		this.setY(nouveau_module * Math.sin(ancien_argument));
	}

	/** Changer l'argument de ce point.
	  * @param nouvel_argument la nouvelle valeur de l'argument.
	  */
	public void setArgument(double nouvel_argument) {
		double m = this.getModule();
		this.setX(m * Math.cos(nouvel_argument));
		this.setY(m * Math.sin(nouvel_argument));
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
	}

	/** Obtenir la distance de ce point par rapport à un autre point.
	  * @param autre l'autre point
	  * @return distance avec l'autre point
	  */
	public double distance(Point autre) {
		double dx2 = Math.pow(autre.x - this.x, 2);
		double dy2 = Math.pow(autre.y - this.y, 2);
		return Math.sqrt(dx2 + dy2);
	}

	/** Translater le point de dx suivant l'axe des X et de dy suivant les Y.
	 * @param dx_ déplacement suivant l'axe des X
	 * @param dy_ déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
		this.x += dx;
		this.y += dy;
	}

}
