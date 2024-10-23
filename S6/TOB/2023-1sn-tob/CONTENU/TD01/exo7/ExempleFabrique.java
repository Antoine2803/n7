/** Illustrer l'utilisation des fabrique.
  * @author	Xavier Crégut <Prenom.Nom@enseeiht.fr>
  */
public class ExempleFabrique {

	public static void main(String[] args) {
		Point p1 = Point.cartesien(1, 4);
		assert 1 == p1.getX();
		assert 4 == p1.getY();

		Point p2 = Point.polaire(2, Math.PI);
		assert 2 == p2.getModule();
		assert Math.PI == p2.getArgument();
	}

}
