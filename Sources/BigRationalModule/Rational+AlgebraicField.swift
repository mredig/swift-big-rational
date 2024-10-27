import RealModule
import BigInt

extension Rational: AlgebraicField {
	@inlinable
	public var reciprocal: Self? {
		getReciprocal()
	}

	@inlinable
	public func getReciprocal() -> Self {
		guard !isZero else { return .nan }

		let numerator = self.denominator
		let denominator = self.numerator

		return Self(numerator: numerator, denominator: denominator, sign: sign)
	}
}
