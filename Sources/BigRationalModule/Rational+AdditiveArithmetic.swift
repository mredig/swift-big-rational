import BigInt

extension Rational: AdditiveArithmetic {
	/// The additive identity, with numerator `1` and denominator `0`.
	@inlinable
	public static var zero: Self {
		Self(0 as BigInt)
	}

	@inlinable
	public static func + (lhs: Self, rhs: Self) -> Self {
		guard lhs.isNaN == false, rhs.isNaN == false else { return .nan }

		let lhsSimplified = lhs.simplifiedValues
		let rhsSimplified = rhs.simplifiedValues
		let n1 = lhsSimplified.numerator * lhsSimplified.sign.rawValue
		let d1 = lhsSimplified.denominator
		let n2 = rhsSimplified.numerator * rhsSimplified.sign.rawValue
		let d2 = rhsSimplified.denominator

		let g = gcd(d1, d2)
		guard g != 1 else {
			let numerator = n1 * d2 + n2 * d1
			let sign = Sign(numerator)
			let posNumerator = BigInt(numerator.magnitude)
			return Rational(numerator: posNumerator, denominator: d1 * d2, sign: sign)
		}

		let s = d1 / g
		let t = n1 * (d2 / g) + n2 * s
		let g2 = gcd(t, g)
		let numerator = t / g2
		let sign = Sign(numerator)
		let posNumerator = BigInt(numerator.magnitude)
		return Self(numerator: posNumerator, denominator: s * (d2 / g2), sign: sign)
	}

	@inlinable
	public static func - (lhs: Self, rhs: Self) -> Self {
		lhs + -(rhs)
	}
}
