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
}
