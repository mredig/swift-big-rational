import Foundation
import Testing
import BigRationalModule
import BigInt

struct EquatableTests {
	@Test func test_basic_equatable() throws {
		let a = Rational("1/2")
		let b = Rational(1, 2)

		#expect(a == b)
	}

	@Test func isIdentical() throws {
		let tests: [(Rational, Rational)] = [
			(Rational(1, 12), Rational(1, 12)),
			(Rational(2, 24, reduced: true), Rational(1, 12)),

			(Rational(Rational(5, 6), 12), Rational(Rational(5, 6), 12)),
			(Rational(Rational(5, 6), 12, reduced: true), Rational(5, 72)),

			(Rational(12, Rational(5, -6)), Rational(12, Rational(5, -6))),
			(Rational(-12, Rational(5, 6), reduced: true), Rational(-72, 5)),

			(Rational(numerator: Rational(10, 11), denominator: Rational(5, -6)), Rational(numerator: Rational(10, 11), denominator: Rational(5, -6))),
			(Rational(numerator: Rational(10, 11), denominator: Rational(5, -6), reduced: true), Rational(-12, 11)),
		]

		for (input, expectation) in tests {
			#expect(input === expectation)
		}
	}

	@Test func isNotIdentical() throws {
		let tests: [(Rational, Rational)] = [
			(Rational(2, 24), Rational(1, 12)),

			(Rational(Rational(5, 6), 12), Rational(5, 72)),

			(Rational(-12, Rational(5, 6)), Rational(-72, 5)),

			(Rational(numerator: Rational(10, 11), denominator: Rational(5, -6)), Rational(-12, 11)),
		]

		for (input, expectation) in tests {
			#expect(input !== expectation)
		}
	}

	@Test func test_unreduced_equatable() throws {
		let a = Rational("1/2")
		let b = Rational(2, 4)

		#expect(a == b)
	}

	@Test func test_negative_equatable() throws {
		let a = Rational("-1/2")
		let b = Rational(1, -2)

		#expect(a == b)
	}

	@Test func test_unreduced_negative2_equatable() throws {
		let a = Rational("-1/2")
		let b = Rational(2, -4)

		#expect(a == b)
	}

	@Test func test_not_equal() throws {
		let a = Rational("1/2")
		let b = Rational(3, 4)

		#expect(a != b)
	}

	@Test func nanEqual() throws {
		let a = Rational.nan
		let b = Rational.nan
		let c = Rational.bigUInt(5, 0, sign: .positive)

		#expect(a == b)
		#expect(a == c)
		#expect(b == c)
		#expect(b == a)
		#expect(c == a)
		#expect(c == b)
	}
}
