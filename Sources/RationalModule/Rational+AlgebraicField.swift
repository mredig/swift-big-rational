import RealModule
import BigInt

extension Rational: AlgebraicField {
	@inlinable
	public var reciprocal: Self? {
		guard !isZero else { return nil }

		var numerator = self.denominator
		var denominator = self.numerator

		if denominator < 0 {
			numerator.negate()
			denominator.negate()
		}

		return Self(numerator: numerator, denominator: denominator, sign: sign)
	}

	@inlinable
	public static func / (lhs: Self, rhs: Self) -> Self {
		guard !rhs.isZero else { fatalError("Cannot divide by zero") }

		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		let g1 = gcd(n1, n2)
		let g2 = gcd(d2, d1)
		var numerator = (n1 / g1) * (d2 / g2)
		var denominator = (d1 / g2) * (n2 / g1)

		if denominator < 0 {
			numerator.negate()
			denominator.negate()
		}

		let sign = Sign.multiplicationOutput(lhs: lhs.sign, rhs: rhs.sign)

		return Self(numerator: numerator, denominator: denominator, sign: sign)
	}

	@inlinable
	public static func /= (lhs: inout Self, rhs: Self) {
		lhs = lhs / rhs
	}
}
