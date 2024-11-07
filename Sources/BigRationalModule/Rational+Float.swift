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
			let den = BigUInt(10).power(decPlace)
			self.init(numerator: .bigUInt(num), denominator: .bigUInt(den), sign: sign)
		} else {
			// whole
			let bigPower = BigUInt(10).power(abs(decPlace))
			self.init(big: num * bigPower, sign: sign)
		}
	}
}
#endif

extension Rational {
	public init?<F: BinaryFloatingPoint>(truncating float: F) {
		guard float.isZero == false else {
			self = .zero
			return
		}
		guard
			float.isFinite,
			float.isSignalingNaN == false,
			float.isNaN == false
		else { return nil }

		let sigCount = F.significandBitCount
		let significandBits = float.significandBitPattern + (1 << sigCount)
		let exponent = Int(float.exponent) - sigCount

		let multiplier: Rational = {
			guard exponent < 0 else {
				return Rational(exactly: BigUInt(2).power(exponent))
			}
			let firstStep = Rational(exactly: BigUInt(2).power(abs(exponent)))
			return Rational(big: 1, firstStep)
		}()

		let significand = Rational(exactly: significandBits)

		self = significand * multiplier
		if float.sign == .minus {
			self *= -1
		}
	}
}
