import BigInt

extension Rational: SignedNumeric {
	public typealias Magnitude = Self

	/// The absolute value of this value.
	///
	/// If the numerator is `T.min`, this property overflows.
	@inlinable
	public var magnitude: Self {
		Self(numerator: numerator, denominator: denominator, sign: .positive)
	}

	/// Converts the given integer to a rational value,
	/// if it can be represented exactly.
	///
	/// 	Rational<Int8>(exactly: 100)      // Rational(100, 1)
	/// 	Rational<Int8>(exactly: 1_000)    // nil
	///
	@inlinable
	public init?(exactly source: some BinaryInteger) {
		guard let value = BigInt(exactly: source) else { return nil }
		self.init(value)
	}

	@inlinable
	public static func * (lhs: Self, rhs: Self) -> Self {
		let n1 = lhs.numerator
		let d1 = lhs.denominator
		let n2 = rhs.numerator
		let d2 = rhs.denominator

		let g1 = gcd(n1, d2)
		let g2 = gcd(n2, d1)

		let sign = Sign.multiplicationOutput(lhs: lhs.sign, rhs: rhs.sign)

		return Self(numerator: (n1 / g1) * (n2 / g2), denominator: (d1 / g2) * (d2 / g1), sign: sign)
	}

	@inlinable
	public static func *= (lhs: inout Self, rhs: Self) {
		lhs = lhs * rhs
	}

	@inlinable
	public static prefix func - (operand: Self) -> Self {
		Rational(
			numerator: operand.numerator,
			denominator: operand.denominator,
			sign: operand.sign.opposite)
	}
}
