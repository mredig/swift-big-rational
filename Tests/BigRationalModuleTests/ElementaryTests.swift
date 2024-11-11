import Foundation
import BigRationalModule
import BigInt
import Testing

struct ElementaryTests {
	@Test func atan2() {}
	@Test func erf() {}
	@Test func erfc() {}

	@Test func exp2() {
		#expect(Rational.exp2(-1) == Rational(1, 2))
		#expect(Rational.exp2(0) == 1)
		#expect(Rational.exp2(Rational(1, 2)) == Rational("3260954456333195409/2305843009213693952"))
		#expect(Rational.exp2(1) == 2)
		#expect(Rational.exp2(8) == 256)
		#expect(Rational.exp2(16) == 65536)
	}

	@Test func exp10() {
		#expect(Rational.exp10(-5) == Rational(1, 100_000))
		#expect(Rational.exp10(-1) == Rational(1, 10))
		#expect(Rational.exp10(0) == 1)
		#expect(Rational.exp10(Rational(1, 2)) == Rational("113933059935810853/36028797018963968"))
		#expect(Rational.exp10(1) == 10)
		#expect(Rational.exp10(8) == 100_000_000)
		#expect(Rational.exp10(16) == 10_000_000_000_000_000)
	}

	@Test func hypot() {}
	@Test func gamma() {}
	@Test func log2() {}
	@Test func log10() {}
	@Test func logGamma() {}
	@Test func signGamma() {}
	@Test func _mulAdd() {}

	@Test func exp() {
		#expect(Rational.exp(.nan).isNaN)
		#expect(Rational.exp(0) == 1)
		#expect(Rational.exp(1) == .e)
		#expect(Rational.exp(Rational(1, 2)).doubleValue() == 1.6487212706997052)
		#expect(Rational.exp(Rational(-1, 2)).doubleValue() == 0.6065306597127891)
		#expect(Rational.exp(-100).doubleValue() == 3.7200759760208356e-44)
	}

	@Test func expMinusOne() {
		#expect(Rational.expMinusOne(0) == 0)
		#expect(Rational.expMinusOne(1) == (.e - 1))
		#expect(Rational.expMinusOne(1).doubleValue() == 1.7182818284590453)
		#expect(Rational.expMinusOne(-1).doubleValue() == -0.6321205588285578)
		#expect(Rational.expMinusOne(20).doubleValue() == 485165194.4097903)
		#expect(Rational.expMinusOne(-45).doubleValue() == -1)
	}

	@Test func cosh() {}
	@Test func sinh() {}
	@Test func tanh() {}
	@Test func cos() {}
	@Test func sin() {}
	@Test func tan() {}
	@Test func log() {}
	@Test func logOnePlus() {}
	@Test func acosh() {}
	@Test func asinh() {}
	@Test func atanh() {}
	@Test func acos() {}
	@Test func asin() {}
	@Test func atan() {}

	@Test func nthPowerInt() throws {
		#expect(Rational.pow(2, 2 as Int) == 4)
		#expect(Rational.pow(-2, 2 as Int) == 4)
		#expect(Rational.pow(2, 3 as Int) == 8)
		#expect(Rational.pow(-2, 3 as Int) == -8)
		#expect(Rational.pow(-3, -1 as Int) == Rational(-1, 3))
		#expect(Rational.pow(3, 6 as Int) == 729)
		#expect(Rational.pow(3, 12 as Int) == 531_441)
		#expect(Rational.pow(3, 13 as Int) == 1_594_323)
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
		#expect(Rational.pow(10, 0 as Int) == 1)
		#expect(Rational.pow(10, 1 as Int) == 10)
		#expect(Rational.pow(10, -1 as Int) == Rational(1, 10))
		#expect(Rational.pow(10, -9 as Int) == Rational(1, 1_000_000_000))

		#expect(Rational.pow(10, 1 as Int) == 10)
		#expect(Rational.pow(10, 2 as Int) == 100)
		#expect(Rational.pow(10, 3 as Int) == 1_000)
		#expect(Rational.pow(10, 4 as Int) == 10_000)
		#expect(Rational.pow(10, 5 as Int) == 100_000)
		#expect(Rational.pow(10, 6 as Int) == 1_000_000)
		#expect(Rational.pow(10, 7 as Int) == 10_000_000)
		#expect(Rational.pow(10, 8 as Int) == 100_000_000)
		#expect(Rational.pow(10, 9 as Int) == 1_000_000_000)
		#expect(Rational.pow(10, 10 as Int) == 10_000_000_000)
		#expect(Rational.pow(10, 11 as Int) == 100_000_000_000)
		#expect(Rational.pow(10, 12 as Int) == 1_000_000_000_000)
		#expect(Rational.pow(10, 13 as Int) == 10_000_000_000_000)
		#expect(Rational.pow(10, 14 as Int) == 100_000_000_000_000)
		#expect(Rational.pow(10, 15 as Int) == 1_000_000_000_000_000)
	}

	@Test func nthRationalPower() throws {
		#expect(Rational.pow(-8, Rational(1, 3)) == -2)
		#expect(Rational.pow(8, Rational(2, 3)) == 4)
		#expect(Rational.pow(9, Rational(1, 2)) == 3)
		#expect(Rational.pow(9, Rational(1, 1)) == 9)
		#expect(Rational.pow(9, Rational.zero) == 1)
		#expect(Rational.pow(2, Rational(-8)) == Rational(1, 256))
		#expect(Rational.pow(8, Rational(-1, 3)) == Rational(1, 2))
		#expect(Rational.pow(0, Rational(1, 3)) == 0)
		#expect(Rational.pow(0, Rational(3, 2)) == 0)
		#expect(Rational.pow(0, Rational.zero) == 1)
		#expect(Rational.pow(0, Rational(-1, 3)).isNaN)
		#expect(Rational.pow(0, Rational(-3)).isNaN)
	}

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

	@Test func nthRoot() throws {
		#expect(Rational.root(27, 3) == 3)
		#expect(Rational.root(3125, 5) == 5)
		#expect(Rational.root(125, 3) == 5)
		#expect(Rational.root(81, 4) == 3)
		#expect(Rational.root(81, 0).isNaN)
		#expect(Rational.root(0, 0).isNaN)
		#expect(Rational.root(1, 0).isNaN)
		#expect(Rational.root(-1, 0).isNaN)
		#expect(Rational.root(7, 1) == 7)
		#expect(Rational.root(-8, 3) == -2)
		#expect(Rational.root(-4, 2).isNaN)
		#expect(Rational.root(16, -2) == Rational(1, 4))
		#expect(Rational.root(4, -2) == Rational(1, 2))

		#expect(Rational.root(Rational(8, 27), 3) == Rational(2, 3))
		#expect(Rational.root(Rational(8, 27), -3) == Rational(3, 2))
		#expect(Rational.root(Rational(-8, 27), -3) == Rational(-3, 2))
	}
}
