import BigInt

extension Rational: Equatable {
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		func reducedEqual(lhs: Self, rhs: Self) -> Bool {
			lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator && lhs.sign == rhs.sign
		}

		let a = lhs.reduced
		let b = rhs.reduced
		return reducedEqual(lhs: a, rhs: b)
	}
}
