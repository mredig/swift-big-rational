import BigInt

extension Rational: Equatable {
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		func basicEquatable(lhs: Self, rhs: Self) -> Bool {
			lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
		}

		let a = lhs.reduced
		let b = rhs.reduced
		return basicEquatable(lhs: a, rhs: b)
	}
}
