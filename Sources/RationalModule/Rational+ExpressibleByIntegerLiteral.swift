import BigInt

extension Rational: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = T.IntegerLiteralType

	@inlinable
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(T(integerLiteral: value))
	}
}

extension Rational {
	/// Converts the given integer to a rational value.
	///
	/// Equivalent to creating a rational value with numerator
	/// equal to `value` and denominator `1`.
	@inlinable
	public init(_ value: T) {
		let sign = Sign(value)
		self.init(numerator: value, denominator: 1, sign: sign)
	}
}
