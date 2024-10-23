/** Programme de test qui détecte une erreur fonctionnelle.  */
public class TEMonnaieEchec extends TestElementaire {

	public TEMonnaieEchec() {
		super("Un test qui échoue (erreur fonctionnelle)");
	}

	public void tester() {
		Assert.assertTrue(false);
	}

	public static void main(String[] args) {
		new TEMonnaieEchec().lancer();
	}

}
