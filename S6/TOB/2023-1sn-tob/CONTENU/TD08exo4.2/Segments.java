/** Segments encapsule la liste des segments dont un point est extrémité.
  * @author	Xavier Crégut
 * @navassoc * "" "*" Segment
 * @stereotype container
  */
public class Segments {
	/** Les segments gérés. */
	private java.util.List<Segment> segments;

	/** Construire une liste vide de segments. */
	public Segments() {
		segments = new java.util.ArrayList<Segment>();
	}

	/** Demander à chaque segment de mettre à jour sa longueur. */
	public void majLongueur() {
		for (Segment s : this.segments) {
			s.majLongueur();
		}
	}

	/** Ajouter un nouveau segment. */
	public void ajouter(Segment s) {
		segments.add(s);
	}

	/** Supprimer un segment. */
	public void supprimer(Segment s) {
		segments.remove(s);
	}

}
