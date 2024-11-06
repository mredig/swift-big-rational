#if canImport(Foundation)
import BigInt
import Foundation

extension Rational {
	public init?(_ decimal: Decimal) {
		guard
			decimal.isNaN == false,
			decimal.isSignaling == false,
			decimal.isSignalingNaN == false,
			decimal.isInfinite == false,
			decimal.isFinite
		else { return nil }

		let decPlace = -decimal.exponent
		let sign = Sign(decimal)

		guard
			let num = BigUInt(exactly: decimal.significand.magnitude)
		else { return nil }

		if decPlace > 0 {
			// fraction
			guard
				let den = BigUInt(exactly: pow(10, decPlace))
			else { return nil }
			self.init(numerator: .bigUInt(num), denominator: .bigUInt(den), sign: sign)
		} else {
			// whole
			let power = pow(10, decimal.exponent)
			guard
				let bigPower = BigUInt(exactly: power)
			else { return nil }
			self.init(num * bigPower, sign: sign)
		}
	}
}

#endif
