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

	internal static let lnOneAndHalf = Rational("399903938307826879733974190160033610849/986284467666564368825418460469762457600")!

	static let ln2 = Rational("4134414281702954663/5964698981193358453")!
}
