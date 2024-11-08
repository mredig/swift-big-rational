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

	public func doubleValue() -> Double {
		let (quotient, remainder) = quotientAndRemainder

		let biggestDouble = BigUInt(Double.greatestFiniteMagnitude)
		let biggestDoubleRational = Rational(big: biggestDouble, sign: .positive)
		let smallestDoubleRational = Rational(big: biggestDouble, sign: .negative)

		guard Rational(big: quotient) < biggestDoubleRational else {
			return .greatestFiniteMagnitude
		}
		guard Rational(big: quotient) > smallestDoubleRational else {
			return -.greatestFiniteMagnitude
		}

		let remaining = Rational(
			numerator: .bigUInt(remainder.magnitude),
			   denominator: simplified.denominator,
			   sign: Sign(remainder))
		   .reduced
		let simplifiedRemaining = {
			let simpleValues = remaining.simplifiedValues
			let doubleGreatest = BigUInt(Double.greatestFiniteMagnitude)
			guard simpleValues.denominator <= doubleGreatest else {
				return remaining.limitDenominator(to: doubleGreatest).simplifiedValues
			}
			return simpleValues
		}()

		let doubleNumerator = Double(BigInt(simplifiedRemaining.numerator) * simplifiedRemaining.sign.rawValue)
		let doubleDenominator = Double(simplifiedRemaining.denominator)
		return (doubleNumerator / doubleDenominator) + Double(quotient)
	}

	public func decimalValue() -> Decimal {
		let (quotient, remainder) = quotientAndRemainder

		let biggestDecimal = BigUInt(exactly: Decimal.greatestFiniteMagnitude)!
		let biggestDecimalRational = Rational(big: biggestDecimal, sign: .positive)
		let smallestDecimalRational = Rational(big: biggestDecimal, sign: .negative)

		guard Rational(big: quotient) < biggestDecimalRational else {
			return .greatestFiniteMagnitude
		}
		guard Rational(big: quotient) > smallestDecimalRational else {
			return -.greatestFiniteMagnitude
		}

		let remaining = Rational(
			numerator: .bigUInt(remainder.magnitude),
			   denominator: simplified.denominator,
			   sign: Sign(remainder))
		   .reduced
		let simplifiedRemaining = {
			let simpleValues = remaining.simplifiedValues
			guard simpleValues.denominator <= biggestDecimal else {
				return remaining.limitDenominator(to: biggestDecimal).simplifiedValues
			}
			return simpleValues
		}()

		let decimalNumerator = Decimal(BigInt(simplifiedRemaining.numerator) * simplifiedRemaining.sign.rawValue)
		let decimalDenominator = Decimal(simplifiedRemaining.denominator)
		return (decimalNumerator / decimalDenominator) + Decimal(quotient)
	}
}

public extension BinaryFloatingPoint {
	init(_ value: Rational) {
		self = Self(value.doubleValue())
	}
}

public extension Decimal {
	init(_ value: Rational) {
		self = value.decimalValue()
	}
}
