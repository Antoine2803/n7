/** Programme de test de la classe Point
  * @author	Xavier Crégut
  */
public class ExemplePoint2 {

	public static void main (String argv []) {
		Point p = new Point(1,0);
		p.x = 10;
		System.out.println("module = " + p.getModule());
	}
}
