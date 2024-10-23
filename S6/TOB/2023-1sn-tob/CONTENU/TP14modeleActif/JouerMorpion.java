/**
  * JouerMorpion permet de jouer au morpion avec plusieurs interfaces et
  * plusieurs contrôleurs.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.2 $
  */

public class JouerMorpion {

	public static void main(String[] args) {
		ModeleMorpionSimple morpion = new ModeleMorpionSimple();

		(new ControleurMorpionGraphique(morpion)).activer();
		(new ControleurMorpionTexte(morpion)).activer();
		(new ControleurMorpionGraphique(morpion)).activer();

		// ajouter une vue Texte
		morpion.ajouterVue(new VueMorpionTexte(morpion));

		morpion.ajouterVue(new VueMorpionGraphique(morpion, "Vue Morpion 1"));
		morpion.ajouterVue(new VueMorpionGraphique(morpion, "Vue Morpion 2"));

		MorpionSwing mSwing = new MorpionSwing(morpion);
		morpion.ajouterVue(mSwing);

		// Attendre un peu et ajouter une nouvelle vue graphique
		// Attention à ne pas quitter avant que cette vue soit affichée !
		try {
			Thread.sleep(5000);	// Attendre 5 secondes.
		} catch(InterruptedException e) {
			e.printStackTrace();
		}
		morpion.ajouterVue(new VueMorpionGraphique(morpion, "Vue Morpion 3"));
		
		morpion.ajouterVue(new VueMorpionScoreTexte(morpion));

	}
}

