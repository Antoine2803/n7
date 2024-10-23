/** Définition d'un ensemble d'entiers implanté sous d'éléments chaînés.
 *  @author	Xavier Crégut &lt;prenom.nom@enseeiht.fr&gt;
  */
public class EnsembleChaineOrdonne<E extends Comparable<E>> extends EnsembleChaine<E> implements EnsembleOrdonne<E> {
	
	@Override public void ajouter(E x) {
		if (this.premiere == null || x.compareTo(this.premiere.element) < 0) {
			// Insérer en tête
			this.premiere = new Cellule<E>(x, this.premiere);
		} else {
			// Trouver la cellule après laquelle insérer
			Cellule<E> curseur = this.premiere;
			while (curseur.suivante != null
					&& curseur.suivante.element.compareTo(x) < 0) {
				curseur = curseur.suivante;
			}

			if (curseur.element != x) {
				curseur.suivante = new Cellule<E>(x, curseur.suivante);
			}
		}
	}

	@Override public void supprimer(E x) {
		if (this.premiere != null) {
			if (this.premiere.element.equals(x)) {
				// Supprimer la première cellule
				this.premiere = this.premiere.suivante;
			} else {
				// Chercher la cellule avant l'élément à supprimer
				Cellule<E> curseur = this.premiere;
				while (curseur.suivante != null && ! curseur.suivante.element.equals(x)) {
					curseur = curseur.suivante;
				}

				if (curseur.suivante != null) {
					curseur.suivante = curseur.suivante.suivante;
				}
			}
		}
	}
	
	@Override public E min() {
		return this.premiere.element;
	}

}
