import Foundation
import BigRationalModule
import BigInt
import Testing

struct EssentialsTests {
	@Test func square() throws {
		func sqTest(_ rational: Rational) -> Bool {
			let square = rational.squareRoot()
			let checkAnswer = square * square
			let answer = checkAnswer == rational
			if answer == false {
				print(checkAnswer.reduced.doubleValue())
			}
			return answer
		}

		#expect(Rational(4).squareRoot() == 2)
		#expect(Rational(9).squareRoot() == 3)
		#expect(Rational(16).squareRoot() == 4)
		#expect(Rational(25).squareRoot() == 5)
		#expect(Rational(36).squareRoot() == 6)
		#expect(Rational(49).squareRoot() == 7)
		#expect(Rational(64).squareRoot() == 8)
		#expect(Rational(81).squareRoot() == 9)
		#expect(Rational(100).squareRoot() == 10)
		#expect(Rational(121).squareRoot() == 11)
//		#expect(Rational(10).squareRoot() == Rational("37938742571742984542/11997283808950188741"))
//		#expect(Rational(1, 2).squareRoot() == Rational("9675306251538732213/13682949321039267322"))
//
//		#expect(sqTest(Rational(4)))
//		#expect(sqTest(Rational(100)))
//		#expect(sqTest(Rational(10)))
//		#expect(sqTest(Rational(1, 2)))
	}
}
