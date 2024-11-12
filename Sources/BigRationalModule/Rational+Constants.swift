import BigInt

public extension Rational {
	static let e = {
		var rat = Rational(1)
		var factorialCarrier = BigUInt(1)
		for i in 1..<34 {
			let den = factorialCarrier * BigUInt(i)
			defer { factorialCarrier = den }
			let new = Rational.bigUInt(1, den)
			rat += new
		}
		return rat
	}()

	internal static let lnOneAndHalf = {
		Rational.computeTaylorSeriesLog(Rational(3, 2), precision: Rational(1, .uIntMax * 9999))
	}()

	// These values were calculated at a higher precision than the log algorithm is currently set to, so they won't
	// match raw calculations exactly
	static let ln2 = {
		Rational.computeTaylorSeriesLog(Rational(2), precision: Rational(1, .uIntMax * 9999))
	}()

	static let ln10 = {
		Rational.computeTaylorSeriesLog(Rational(10), precision: Rational(1, .uIntMax * 9999))
	}()

	static func generatePi(decimalPlaces: Int) -> Rational {
		var q: BigUInt = 1
		var r: BigUInt = 180
		var t: BigUInt = 60

		var value = Rational.zero
		var ratio = Rational(1)
		for i in 2...BigUInt(decimalPlaces + 1) {
			let u: BigUInt = 3 * (3 * i + 1) * (3 * i + 2)
			var y = (q * (27 * i - 12) + 5 * r) / (5 * t)
			(q, r, t) = (
				10 * q * (i * (2 * i - 1)),
				10 * (q * (5 * i - 2) + r - y * t) * u,
				t * u)

			if y >= 10 {
				y = y % 10
			}
			let digit = Rational.bigUInt(BigUInt(y)) * ratio
			value += digit
			ratio /= 10
		}
		return value
	}

	static let pi = {
		generatePi(decimalPlaces: 100)
	}()
}
