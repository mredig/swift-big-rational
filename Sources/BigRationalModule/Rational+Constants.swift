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

	static func genPi2(iterations: Int) -> Rational {
		let den = (iterations * 2) + 1
		var value: Rational = Rational(iterations, den) + 2
		for x in stride(from: iterations, through: 1, by: -1) {
			let term = Rational(x, x * 2 + 1)
			value = term * value + 2
		}
		return value
	}

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
	static let pi = { @Sendable (iterations: Int) in
		var numeratorSum = Rational.zero

		var factorialCalc = BigUIntFactorialCalculator()

		for i in 0..<iterations {
			let k = BigInt(i)
			let kk = BigUInt(i)
			var term = pow(-1, k) * factorialCalc.factorial(of: 6 * kk) * (545140134 * kk + 13591409)
			let divisor = {
				let a = factorialCalc.factorial(of: 3 * kk)
				let b = factorialCalc.factorial(of: kk).power(3)
				let c1 = Rational(640320)
				let c2 = Rational(3, 2) + Rational.bigUInt(3 * kk, 1)
				let c = pow(c1, c2)
				return Rational.bigUInt(a) * Rational.bigUInt(b) * c
			}()
			numeratorSum += term / divisor
		}

		return (1 / (12 * numeratorSum)).reduced
	}
}
