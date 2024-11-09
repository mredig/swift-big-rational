import Foundation
import BigRationalModule
import BigInt
import Testing

struct ElementaryTests {
	@Test func square() throws {
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
	}
}
