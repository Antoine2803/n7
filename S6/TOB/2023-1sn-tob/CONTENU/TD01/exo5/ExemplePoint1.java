/** Programme de test de la classe Point.
  * @author	Xavier Crégut
  */
public class ExemplePoint1 {

	public static void main (String argv []) {
		Point p = new Point(1,0);
		System.out.println("abscisse = " + p.getX());
		System.out.println("module = " + p.getModule());
		p.translater(-1, 1);
		p.afficher();
		System.out.println();
	}
}
