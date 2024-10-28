import Testing
import BigRationalModule
import BigInt

struct RationalConvenienceInitializers {
	@Test func oneOverBigInt() {
		let tests: [(input: BigInt, expectation: Rational)] = [
			(5, Rational(1, 5)),
			(-5, Rational(1, -5)),
			(0, .nan)
		]

		for (input, expectation) in tests {
			let testedValue = Rational.oneOver(input)
			#expect(testedValue == expectation)
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
			#expect(testedValue == expectation)
		}
	}
}
