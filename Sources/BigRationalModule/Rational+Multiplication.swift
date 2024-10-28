import BigInt

extension Rational {
	// MARK: - Multiplication
	@inlinable
	public static func * (lhs: Self, rhs: Self) -> Self {
		guard
			lhs.isNaN == false,
			rhs.isNaN == false
		else { return .nan }

		let lhsSimplified = lhs.simplifiedValues
		let rhsSimplified = rhs.simplifiedValues

		let n1 = lhsSimplified.numerator * lhsSimplified.sign.rawValue
		let d1 = lhsSimplified.denominator
		let n2 = rhsSimplified.numerator * rhsSimplified.sign.rawValue
		let d2 = rhsSimplified.denominator

		let g1 = gcd(n1, d2)
		let g2 = gcd(n2, d1)

		let numerator = (n1 / g1) * (n2 / g2)
		let denominator = (d1 / g2) * (d2 / g1)

		return Self(numerator, denominator)
	}

	@inlinable
	public static func * <SN: SignedInteger>(lhs: Self, rhs: SN) -> Self {
		lhs * Rational(rhs, 1)
	}

	@inlinable
	public static func *= <SN: SignedInteger>(lhs: inout Self, rhs: SN) {
		lhs = lhs * rhs
	}

	@inlinable
	public static func * <UN: UnsignedInteger>(lhs: Self, rhs: UN) -> Self {
		lhs * BigInt(rhs)
	}

	@inlinable
	public static func *= <UN: UnsignedInteger>(lhs: inout Self, rhs: UN) {
		lhs = lhs * rhs
	}

	@inlinable
	public static func *= (lhs: inout Self, rhs: Self) {
		lhs = lhs * rhs
	}

	// MARK: - Division
	@inlinable
	public static func / (lhs: Self, rhs: Self) -> Self {
		guard rhs.isZero == false else { return .nan }
		guard rhs.isNaN == false, lhs.isNaN == false else { return .nan }

		let lhsSimplified = lhs.simplifiedValues
		let rhsSimplified = rhs.simplifiedValues

		let n1 = lhsSimplified.numerator * lhsSimplified.sign.rawValue
		let d1 = lhsSimplified.denominator
		let n2 = rhsSimplified.numerator * rhsSimplified.sign.rawValue
		let d2 = rhsSimplified.denominator

		let g1 = gcd(n1, n2)
		let g2 = gcd(d2, d1)
		let numerator = (n1 / g1) * (d2 / g2)
		let denominator = (d1 / g2) * (n2 / g1)

		return Self(numerator, denominator)
	}

	@inlinable
	public static func / <SN: SignedInteger>(lhs: Self, rhs: SN) -> Self {
		lhs / Rational(rhs, 1)
	}

	@inlinable
	public static func / <UN: UnsignedInteger>(lhs: Self, rhs: UN) -> Self {
		lhs / BigInt(rhs)
	}

	@inlinable
	public static func /= <SN: SignedInteger>(lhs: inout Self, rhs: SN) {
		lhs = lhs / rhs
	}

	@inlinable
	public static func /= <UN: UnsignedInteger>(lhs: inout Self, rhs: UN) {
		lhs = lhs / rhs
	}

	@inlinable
	public static func /= (lhs: inout Self, rhs: Self) {
		lhs = lhs / rhs
	}

}
