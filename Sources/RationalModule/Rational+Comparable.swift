import BigInt

extension Rational: Comparable {
	@inlinable
	public static func < (lhs: Self, rhs: Self) -> Bool {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		// n1   n2    n1 * d2   n2 * d1
		// -- < -- => ------- < ------- => n1 * d2 < n2 * d1
		// d1   d2    d1 * d2   d1 * d2
		let a = n1 * d2
		let b = n2 * d1

		return a < b
	}
}
