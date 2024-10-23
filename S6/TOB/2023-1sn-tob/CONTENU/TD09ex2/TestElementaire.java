/** TestElementaire décrit un seul test.
 * @depend_notdefined - <send> - DeviseInvalideException
 * @author	Xavier Crégut
 * @version	$Revision: 1.2 $
 */
abstract public class TestElementaire implements Test {

	/** Le nom du test. */
	private String nom;

	/** Initialiser ce test.
	 * @param sonNom le nom du test
	 */
	public TestElementaire(String sonNom) {
		this.nom = sonNom;
	}

	final public void lancer() {
		ResultatTest resultats = new ResultatTest();
		this.lancer(resultats);
		System.out.println(resultats);
	}

	final public void lancer(ResultatTest resultats) {
		throw new RuntimeException("Implantation de lancer(ResultatTest) "
				+ " non fournie !");
	}

	/** Préparer les données pour le test. */
	protected void preparer() throws Throwable {
	}

	/** Réaliser le test effectif. */
	abstract protected void tester() throws Throwable;

	/** Nettoyer après l'exécution de tester. */
	protected void nettoyer() throws Throwable {
	}

}
