import BigInt

extension Rational: Comparable {
	@inlinable
	public static func < (lhs: Self, rhs: Self) -> Bool {
		guard
			lhs.isNaN == false,
			rhs.isNaN == false
		else { return false }

		let lhsSimplified = lhs.simplifiedValues
		let rhsSimplified = rhs.simplifiedValues

		let n1 = lhsSimplified.numerator * lhsSimplified.sign.rawValue
		let d1 = lhsSimplified.denominator
		let n2 = rhsSimplified.numerator * rhsSimplified.sign.rawValue
		let d2 = rhsSimplified.denominator

		// n1   n2    n1 * d2   n2 * d1
		// -- < -- => ------- < ------- => n1 * d2 < n2 * d1
		// d1   d2    d1 * d2   d1 * d2
		let a = n1 * d2
		let b = n2 * d1

		return a < b
	}

	@inlinable
	public static func > (lhs: Self, rhs: Self) -> Bool {
		rhs < lhs
	}

	@inlinable
	public static func >= (lhs: Self, rhs: Self) -> Bool {
		guard lhs != rhs else {
			return true
		}
		return lhs > rhs
	}

	@inlinable
	public static func <= (lhs: Self, rhs: Self) -> Bool {
		guard lhs != rhs else {
			return true
		}
		return lhs < rhs
	}

}
