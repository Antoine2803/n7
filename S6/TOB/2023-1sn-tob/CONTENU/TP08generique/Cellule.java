/** Une cellule encapsule un élément et un accès
 * à une autre cellule dite suivante.
 */
class Cellule<E> {
	E element;
	Cellule<E> suivante;

	//@ ensures this.element == element;
	//@ ensures this.suivante == suivante;
	Cellule(E element, Cellule<E> suivante) {
		this.element = element;
		this.suivante = suivante;
	}

	@Override public String toString() {
		// Attention, il ne faut pas que les cellules forment un cycle !
		return "[" + this.element + "]--"
				+ (this.suivante == null ? 'E' : ">" + this.suivante); 
	}

}
