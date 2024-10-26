import BigInt

extension Rational: ExpressibleByIntegerLiteral {
	@inlinable
	public init(integerLiteral value: Int64) {
		self.init(BigInt(integerLiteral: value))
	}
}

extension Rational {
	/// Converts the given integer to a rational value.
	///
	/// Equivalent to creating a rational value with numerator
	/// equal to `value` and denominator `1
	@inlinable
	public init(_ value: BigInt) {
		let sign = Sign(value)
		self.init(numerator: value, denominator: 1, sign: sign)
	}

	/// Converts the given integer to a rational value.
	///
	/// Equivalent to creating a rational value with numerator
	/// equal to `value` and denominator `1`.
	@inlinable
	public init(_ value: BigUInt, sign: Sign) {
		self.init(numerator: BigInt(value), denominator: 1, sign: sign)
	}
}
