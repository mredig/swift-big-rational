import BigInt

extension Rational: Equatable {
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		func basicEquatable(lhs: Self, rhs: Self) -> Bool {
			lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
		}

		let a = lhs.normalized
		let b = rhs.normalized
		return basicEquatable(lhs: a, rhs: b)
	}
}
