import Foundation
import BigRationalModule
import BigInt
import Testing

struct ElementaryTests {
	@Test func squareRoot() throws {
		#expect(Rational.sqrt(Rational(1)) == 1)
		#expect(Rational.sqrt(Rational(4)) == 2)
		#expect(Rational.sqrt(Rational(9)) == 3)
		#expect(Rational.sqrt(Rational(16)) == 4)
		#expect(Rational.sqrt(Rational(25)) == 5)
		#expect(Rational.sqrt(Rational(36)) == 6)
		#expect(Rational.sqrt(Rational(49)) == 7)
		#expect(Rational.sqrt(Rational(64)) == 8)
		#expect(Rational.sqrt(Rational(81)) == 9)
		#expect(Rational.sqrt(Rational(100)) == 10)
		#expect(Rational.sqrt(Rational(121)) == 11)

		#expect(Rational.sqrt(Rational(1, 4)) == Rational(1, 2))
		#expect(Rational.sqrt(Rational(1, 100)) == Rational(1, 10))
		#expect(Rational.sqrt(Rational(1, 25)) == Rational(1, 5))
		#expect(Rational.sqrt(Rational(9, 100)) == Rational(3, 10))
		#expect(Rational.sqrt(Rational(4, 25)) == Rational(2, 5))
		#expect(Rational.sqrt(Rational(9, 25)) == Rational(3, 5))
		#expect(Rational.sqrt(Rational(49, 100)) == Rational(7, 10))
		#expect(Rational.sqrt(Rational(16, 25)) == Rational(4, 5))
		#expect(Rational.sqrt(Rational(81, 100)) == Rational(9, 10))

		#expect(Rational.sqrt(Rational(9, 4)) == Rational(3, 2))
		#expect(Rational.sqrt(Rational(25, 4)) == Rational(5, 2))
		#expect(Rational.sqrt(Rational(169, 4)) == Rational(13, 2))
		#expect(Rational.sqrt(Rational(64, 25)) == Rational(8, 5))
		#expect(Rational.sqrt(Rational(2401, 100)) == Rational(49, 10))

		#expect(Rational.sqrt(Rational.zero) == .zero)
		#expect(Rational.sqrt(Rational.nan) === .nan)
		#expect(Rational.sqrt(Rational(-5, 1)) === .nan)
		#expect(Rational.sqrt(Rational(-1, 200)) === .nan)
	}

	@Test func squareRootIrrational() throws {
		func theTest(_ value: Rational) -> Bool {
			let result = Rational.sqrt(value)

			let squared = result * result

			let valueDouble = value.doubleValue()
			let squaredDouble = squared.doubleValue()

			return abs(squaredDouble - valueDouble) < 0.00000001
		}

		#expect(theTest(10))
		#expect(theTest(11))
		#expect(theTest(12))
		#expect(theTest(13))
		#expect(theTest(500))
	}

	@Test func nthPower() throws {
		#expect(Rational.pow(2, 2 as Int) == 4)
		#expect(Rational.pow(-2, 2 as Int) == 4)
		#expect(Rational.pow(2, 3 as Int) == 8)
		#expect(Rational.pow(-2, 3 as Int) == -8)
		#expect(Rational.pow(-3, -1 as Int) == Rational(-1, 3))
		#expect(Rational.pow(3, 8 as Int) == 6561)
		#expect(Rational.pow(3, 9 as Int) == 19683)
		#expect(Rational.pow(2, -2 as Int) == Rational(1, 4))
		#expect(Rational.pow(2, -3 as Int) == Rational(1, 8))
		#expect(Rational.pow(-2, -3 as Int) == Rational(-1, 8))
		#expect(Rational.pow(Rational(1, 1_000_000), -1 as Int) == 1_000_000)
		#expect(Rational.pow(Rational(1, 2), -1 as Int) == 2)
		#expect(Rational.pow(Rational(1, 2), 3 as Int) == Rational(1, 8))
		#expect(Rational.pow(Rational.zero, 3 as Int) == .zero)
		#expect(Rational.pow(Rational.zero, -1 as Int).isNaN)
		#expect(Rational.pow(Rational.zero, -3 as Int).isNaN)
		#expect(Rational.pow(Rational.zero, 0 as Int) == 1)
		#expect(Rational.pow(Rational.nan, 0 as Int).isNaN)
		#expect(Rational.pow(Rational.nan, 1 as Int).isNaN)
		#expect(Rational.pow(Rational.nan, 5 as Int).isNaN)
		#expect(Rational.pow(10, 9 as Int) == 1_000_000_000)
		#expect(Rational.pow(10, 0 as Int) == 1)
		#expect(Rational.pow(10, 1 as Int) == 10)
		#expect(Rational.pow(10, -1 as Int) == Rational(1, 10))
		#expect(Rational.pow(10, -9 as Int) == Rational(1, 1_000_000_000))
	}
}
