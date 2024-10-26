import Testing
import BigRationalModule
import BigInt

struct IntegerLiteralTests {
	@Test func test_literal_2_returns_2_over_1() throws {
		let r: Rational = 2
		#expect(r.numerator == 2)
		#expect(r.denominator == 1)
	}

	@Test func initFromBigUInt() throws {
		let new = Rational(BigUInt(1234), sign: .positive)
		#expect(new == Rational(1234, 1, sign: .positive))
	}

	@Test func initNegativeFromBigUInt() throws {
		let new = Rational(BigUInt(1234), sign: .negative)
		#expect(new == Rational(1234, 1, sign: .negative))
	}

	@Test func initExactlyFromBinaryInteger() throws {
		let new = Rational(exactly: 1234)
		#expect(new == Rational(1234, 1, sign: .positive))
	}
}
