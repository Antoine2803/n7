/** Définition d'un point mathématique dans un plan qui peut être
  * considéré dans un repère cartésien ou polaire.  Un point peut être affiché,
  * translaté.  Sa distance par rapport à un autre point peut être obtenue.
  * @author	Xavier Crégut <nom@n7.fr>
  */
public class Point {

	private double module;	// module de ce point
	private double argument;	// argument de ce point

	/**  Construire un point à partir de son abscisse et de son ordonnée.
	  *  @param	vx	valeur de l'abscisse
	  *  @param	vy	valeur de l'ordonnée
	  */
	public Point(double vx, double vy) {
		this.setX(vx);
		this.setY(vy);
	}

	/** Changer l'abscisse de ce point.
	  * @param vx	la nouvelle valeur de l'abscisse
	  */
	public void setX(double vx) {
		double vy = this.getY();
		this.module = Math.sqrt(vx * vx + vy * vy);
		this.argument = Math.atan2(vy, vx);
	}

	/** Changer l'ordonnée de ce point.
	  * @param vy	la nouvelle valeur de l'ordonnée
	  */
	public void setY(double vy) {
		double vx = this.getX();
		this.module = Math.sqrt(vx * vx + vy * vy);
		this.argument = Math.atan2(vy, vx);
	}

	/** Obtenir l'abscisse de ce point.
	  * @return abscisse de ce point
	  */
	public double getX() {
		return this.module * Math.cos(this.argument);
	}

	/** Obtenir l'ordonnée de ce point.
	  * @return ordonnée de ce point
	  */
	public double getY() {
		return this.module * Math.sin(this.argument);
	}

	/** Obtenir le module de ce point.
	  * @return module de ce point
	  */
	public double getModule() {
		return this.module;
	}

	/** Obtenir l'argument de ce point.
	  * @return l'argument de ce point
	  */
	public double getArgument() {
		return this.argument;
	}

	/** Changer le module de ce point.
	  * @param nouveau_module la nouvelle valeur du module
	  */
	public void setModule(double nouveau_module) {
		this.module = nouveau_module;
	}

	/** Changer l'argument de ce point.
	  * @param nouvel_argument la nouvelle valeur de l'argument.
	  */
	public void setArgument(double nouvel_argument) {
		this.argument = nouvel_argument;
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.getX() + "," + this.getY() + ")");
		// Remarque : il n'y a pas de retour à la ligne (print et non
		// println) car c'est à celui qui affiche le point de savoir
		// s'il souhaite ou non ajouter un retour à la ligne.
	}

	/** Obtenir la distance de ce point par rapport à un autre point.
	  * @param autre l'autre point
	  * @return distance avec l'autre point
	  */
	public double distance(Point autre) {
		double dx2 = Math.pow(autre.getX() - this.getX(), 2);
		double dy2 = Math.pow(autre.getY() - this.getY(), 2);
		return Math.sqrt(dx2 + dy2);
	}

	/** Translater le point de dx suivant l'axe des X et de dy suivant les Y.
	 * @param dx_ déplacement suivant l'axe des X
	 * @param dy_ déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
		this.setX(this.getX() + dx);
		this.setY(this.getY() + dy);
	}

}
