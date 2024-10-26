import RealModule
import BigInt

extension Rational: AlgebraicField {
	@inlinable
	public var reciprocal: Self? {
		guard !isZero else { return nil }

		let numerator = self.denominator
		let denominator = self.numerator

		return Self(numerator: numerator, denominator: denominator, sign: sign)
	}
}
