/** Scénario d'utilisation de la classe Banque */
public class TestBanque {

	public static void main(String argv []) {
		Banque b = new Banque(10);
		Personne p1 = new Personne("Xavier", "Crégut", true);
		Personne p2 = new Personne("Marc", "Pantel", true);

		b.ouvrirCompteSimple(p1, 100);
		b.ouvrirCompteSimple(p2, 300);
		b.ouvrirCompteCourant(p1, 90);
		b.ouvrirCompteCourant(p2, 50);
		// b.ouvrirLivretA(p1, 200);
		// b.ouvrirLivretA(p2, 200);

		System.out.println("Cumul de la banque : " + b.getCumulSoldes());

		System.out.println();
		System.out.println("Lister les comptes :");
		System.out.println("====================");
		b.lister();

		System.out.println("Prélèvement des frais bancaires.");
		b.preleverFrais();

		System.out.println("Cumul de la banque : " + b.getCumulSoldes());


		System.out.println();
		System.out.println("Édition des relevés :");
		System.out.println("=====================");
		b.editerReleves();
	}
}
