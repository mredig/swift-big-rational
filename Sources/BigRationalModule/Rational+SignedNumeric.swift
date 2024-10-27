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
	/// 	Rational(exactly: 100)      // Rational(100, 1)
	/// 	Rational(exactly: 1_000)    // Rational(1000, 1)
	///
	@inlinable
	public init?(exactly source: some BinaryInteger) {
		guard let value = BigInt(exactly: source) else { return nil }
		self.init(value)
	}

	@inlinable
	public static prefix func - (operand: Self) -> Self {
		Rational(
			numerator: operand.numerator,
			denominator: operand.denominator,
			sign: operand.sign.opposite)
	}
}
