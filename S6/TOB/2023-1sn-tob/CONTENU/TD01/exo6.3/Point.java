/** Définition d'un point mathématique dans un plan qui peut être
  * considéré dans un repère cartésien ou polaire.  Un point peut être affiché,
  * translaté.  Sa distance par rapport à un autre point peut être obtenue.
  * @author	Xavier Crégut <nom@n7.fr>
  */
public class Point {

	// ATTENTION : avoir des attributs publics est une mauvaise pratique !
	public double x;		// abscisse de ce point
	public double y;		// ordonnée de ce point
	public double module;	// module de ce point
	public double argument;	// argument de ce point

	/**  Construire un point à partir de son abscisse et de son ordonnée.
	  *  @param	vx	valeur de l'abscisse
	  *  @param	vy	valeur de l'ordonnée
	  */
	public Point(double vx, double vy) {
		this.x = vx;
		this.y = vy;
		this.majPolaire();
	}

	/** Changer l'abscisse de ce point.
	  * @param vx	la nouvelle valeur de l'abscisse
	  */
	public void setX(double vx) {
		this.x = vx;
		this.majPolaire();
	}

	/** Changer l'ordonnée de ce point.
	  * @param vy	la nouvelle valeur de l'ordonnée
	  */
	public void setY(double vy) {
		this.y = vy;
		this.majPolaire();
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
		this.majCartesien();
	}

	/** Changer l'argument de ce point.
	  * @param nouvel_argument la nouvelle valeur de l'argument.
	  */
	public void setArgument(double nouvel_argument) {
		this.argument = nouvel_argument;
		this.majCartesien();
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
		// Remarque : il n'y a pas de retour à la ligne (print et non
		// println) car c'est à celui qui affiche le point de savoir
		// s'il souhaite ou non ajouter un retour à la ligne.
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
		this.majPolaire();
	}

	/** Mettre à jour les coordonnées polaires.  */
	private void majPolaire() {
		this.module = Math.sqrt(this.x * this.x + this.y * this.y);
		this.argument = Math.atan2(this.y, this.x);
	}

	/** Mettre à jour les coordonnées cartésiennes.  */
	private void majCartesien() {
		this.x = this.module * Math.cos(this.argument);
		this.y = this.module * Math.sin(this.argument);
	}

}
