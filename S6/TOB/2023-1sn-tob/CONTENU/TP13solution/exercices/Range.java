package exercices;

import java.util.Iterator;

public class Range implements Iterable<Integer> {
	/*
	 * TODO : La classe Range hÃ©rite de Object.  Il faudrait donc redÃ©finir
	 * la mÃ©thode equals (deux Range sont Ã©gaux ssi ils ont mÃªme dÃ©but,
	 * mÃªme fin et mÃªme pas) et la mÃ©thode hashCode.
	 *
	 * TODO : Il faudrait aussi traiter les pas nÃ©gatifs.
	 */

	private int start, end, step;

	protected Range(int start, int end, int step) {
		if (step <= 0) {
			throw new IllegalArgumentException("required: step > 0,"
					+ " found: step = " + step);
		}
		this.start = start;
		this.end = end;
		this.step = step;
	}

	public static Range range(int start, int end, int step) {
		return new Range(start, end, step);
	}

	public static Range range(int start, int end) {
		return range(start, end, 1);
	}

	public static Range range(int end) {
		return range(0, end, 1);
	}


	@Override public Iterator<Integer> iterator() {
		return new RangeIterator();
	}

	private class RangeIterator implements Iterator<Integer> {
		private int next = start;

		@Override public boolean hasNext() {
			return next < end;
		}

		@Override public Integer next() {
			if (! hasNext()) {
				throw new java.util.NoSuchElementException();
			}
			int p = next;
			next += step;
			return p;
		}
	}

}
