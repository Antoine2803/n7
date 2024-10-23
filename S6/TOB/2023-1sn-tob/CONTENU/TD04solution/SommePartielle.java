/** Calculer la somme des paramètres de la ligne de commande.  */
public class SommePartielle {

	/* Afficher la somme des arguments de la ligne de commande */
	public static void main(String[] args) {
		double somme = 0;
		try {
			for (int i = 0; i < args.length; i++) {
				somme += Double.parseDouble(args[i]);
			}
		} catch (NumberFormatException e) {
			System.out.println("Attention, somme partielle");
		}
		System.out.println(somme);
	}

}
