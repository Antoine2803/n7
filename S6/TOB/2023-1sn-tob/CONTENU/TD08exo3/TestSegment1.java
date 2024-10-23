/** Premier programme de Test de la classe Segment.
// AUTEUR START DELETE
 * @author  Xavier Crégut
// AUTEUR STOP DELETE
// UMLGRAPH START DELETE
 * @hidden
// UMLGRAPH STOP DELETE
 */
public class TestSegment1 {
	public static void main(String[] args) {
		Point p1 = new Point(0, 0);
		Point p2 = new Point(5, 0);
		Segment s = new Segment(p1, p2);

		System.out.print("p2 = ");  p2.afficher();  System.out.println();
		System.out.print("s = ");   s.afficher();   System.out.println();
		System.out.println("longueur de s = " + s.getLongueur());

		p2.translater(-2, 0);

		System.out.print("p2 = ");  p2.afficher();  System.out.println();
		System.out.print("s = ");   s.afficher();   System.out.println();
		System.out.println("longueur de s = " + s.getLongueur());
	}
}
