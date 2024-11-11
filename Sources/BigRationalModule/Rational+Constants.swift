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
}
