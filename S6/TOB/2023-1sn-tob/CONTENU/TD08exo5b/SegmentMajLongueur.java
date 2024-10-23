/** Observateur chargé de mettre à jour la longueur d'un segment.
  * @author	Xavier Crégut
  */
public class SegmentMajLongueur implements Observateur {

	/** Le segment à mettre à jour. */
	private Segment leSegment;

	/** Initialiser à partir du segment à mettre à jour. */
	public SegmentMajLongueur(Segment s) {
		leSegment = s;
	}

	public void maj() {
		leSegment.majLongueur();
	}
}
