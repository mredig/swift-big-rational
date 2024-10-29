import Testing
import BigRationalModule
import BigInt

struct RationalConvenienceInitializersTests {
	@Test func oneOverBigInt() {
		let tests: [(input: BigInt, expectation: Rational)] = [
			(5, Rational(1, 5)),
			(-5, Rational(1, -5)),
			(0, .nan)
		]

		for (input, expectation) in tests {
			let testedValue = Rational.oneOver(input)
			guard testedValue == expectation else {
				#expect(testedValue.isNaN == expectation.isNaN)
				return
			}
			#expect(testedValue == expectation)
		}
	}

	@Test func oneOverBigIntParts() throws(Error) {
		let tests: [(input: BigInt, n: Rational.Storage, d: Rational.Storage, sign: Rational.Sign)] = [
			(5, .bigUInt(1), .bigUInt(5), .positive),
			(-5, .bigUInt(1), .bigUInt(5), .negative),
			(0, .bigUInt(0), .bigUInt(0), .zero)
		]

		for (input, numerator, denominator, sign) in tests {
			let testedValue = Rational.oneOver(input)

			#expect(testedValue.numerator === numerator)
			#expect(testedValue.denominator === denominator)
			#expect(testedValue.sign == sign)
		}
	}

	@Test func oneOverRational() {
		let tests: [(input: Rational, expectation: Rational)] = [
			(Rational(5, 6), Rational(6, 5)),
			(Rational(-5, 6), Rational(6, -5)),
			(Rational(5, -6), Rational(-6, 5)),
			(Rational(-5, -6), Rational(6, 5)),
			(.zero, .nan),
			(.nan, .nan),
		]

		for (input, expectation) in tests {
			let testedValue = Rational.oneOver(input)
			guard testedValue == expectation else {
				#expect(testedValue.isNaN == expectation.isNaN)
				return
			}
			#expect(testedValue == expectation)
		}
	}

	@Test func oneOverRationalParts() {
		let tests: [(input: Rational, n: Rational.Storage, d: Rational.Storage, sign: Rational.Sign)] = [
			(Rational(5, 6), .bigUInt(1), .rational(Rational(5, 6)), .positive),
			(Rational(-5, 6), .bigUInt(1), .rational(Rational(-5, 6)), .positive),
			(Rational(5, -6), .bigUInt(1), .rational(Rational(5, -6)), .positive),
			(Rational(-5, -6), .bigUInt(1), .rational(Rational(-5, -6)), .positive),
//			(.zero, .nan),
//			(.nan, .nan),
		]

		for (input, numerator, denominator, sign) in tests {
			let testedValue = Rational.oneOver(input)

			#expect(testedValue.numerator === numerator)
			#expect(testedValue.denominator === denominator)
			#expect(testedValue.sign == sign)
		}
	}

	@Test func identityFractionBigInt() {
		let tests: [(input: BigInt, expectation: Rational)] = [
			(5, Rational(5, 5)),
			(-5, Rational(-5, -5)),
			(0, .nan)
		]

		for (input, expectation) in tests {
			let testedValue = Rational.identityFraction(of: input)
			guard testedValue == expectation else {
				#expect(testedValue.isNaN == expectation.isNaN)
				return
			}
			#expect(testedValue == expectation)
		}
	}

	@Test func identityFractionRational() {
		let tests: [(input: Rational, expectation: Rational)] = [
			(Rational(7, 8), Rational(numerator: Rational(7, 8), denominator: Rational(7, 8))),
			(Rational(7, 8), 1),
			(Rational(-7, 8), Rational(numerator: Rational(-7, 8), denominator: Rational(-7, 8))),
			(Rational(-7, 8), 1),
			(.nan, .nan),
			(.zero, .nan)
		]

		for (input, expectation) in tests {
			let testedValue = Rational.identityFraction(of: input)
			guard testedValue == expectation else {
				#expect(testedValue.isNaN == expectation.isNaN)
				return
			}
			#expect(testedValue == expectation)
		}
	}

	enum Error: Swift.Error {
		case wrongType
	}
}
