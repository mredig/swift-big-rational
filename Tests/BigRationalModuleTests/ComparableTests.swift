import Testing
import BigRationalModule

struct ComparableTests {
	@Test(arguments: [
		(Rational.zero, Rational(1)),
		(Rational(-1), Rational.zero),
		(Rational(-1), Rational(1)),
		(Rational(-1000), Rational(1000)),
		(Rational(-1, 4), Rational(1, 8)),
		(Rational(-1, 4), Rational(-1, 8)),
		(Rational(-1, 4), Rational(1, 4)),
		(Rational(1, 8), Rational(1, 4)),
		(Rational(4), Rational(8)),
		(Rational(-8), Rational(-4)),
		(Rational(10_000, 100_000), Rational(1)),
	])
	func smallerLessThanLarge(_ smaller: Rational, _ larger: Rational) throws {
		#expect(smaller < larger)
		#expect(larger > smaller)
	}

	@Test(arguments: [
		(Rational.zero, Rational(1)),
		(Rational(-1), Rational.zero),
		(Rational(-1), Rational(1)),
		(Rational(-1000), Rational(1000)),
		(Rational(-1, 4), Rational(1, 8)),
		(Rational(-1, 4), Rational(-1, 8)),
		(Rational(-1, 4), Rational(1, 4)),
		(Rational(1, 8), Rational(1, 4)),
		(Rational(4), Rational(8)),
		(Rational(-8), Rational(-4)),
		(Rational(10_000, 100_000), Rational(1)),

		(Rational.zero, Rational.zero),
		(Rational(-1), Rational(-1)),
		(Rational(1), Rational(1)),
		(Rational(1000), Rational(1000)),
		(Rational(1, 4), Rational(1, 4)),
		(Rational(10_000, 100_000), Rational(100_000, 1_000_000)),
	])
	func smallerOrEqualLessOrEqualToLarge(_ smaller: Rational, _ larger: Rational) throws {
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}


	@Test(arguments: [
		(Rational.nan, Rational(1)),
		(Rational(1), Rational.nan),
		(Rational.nan, Rational.nan),
	])
	func allNaNFalse(_ a: Rational, _ b: Rational) throws {
		#expect((a <= b) == false)
		#expect((a < b) == false)
		#expect((b <= a) == false)
		#expect((b < a) == false)
		#expect((a >= b) == false)
		#expect((a > b) == false)
		#expect((b >= a) == false)
		#expect((b > a) == false)
	}
}
