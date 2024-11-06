import Testing
import BigRationalModule
import BigInt
import Foundation

struct FloatTests {
	@Test(arguments: [
		(Decimal.zero, Rational.zero),
		(Decimal(1), Rational(1)),
		(Decimal(-1), Rational(-1)),
		(Decimal(1.25), Rational(125, 100)),
		(Decimal(-1.25), Rational(-125, 100)),
		(Decimal(UInt.max) * 2, Rational(BigInt(UInt.max) * 2)),
		(-Decimal(UInt.max) * 2, Rational(-BigInt(UInt.max) * 2)),
		(Decimal(UInt.max) + 25.5, Rational(BigInt("184467440737095516405"), BigInt(10))),
		(-Decimal(UInt.max) - 25.5, Rational(-BigInt("184467440737095516405"), BigInt(10))),
	])
	func initFromDecimalExact(_ value: Decimal, _ expectation: Rational) throws {
		#expect(Rational(value)! === expectation)
	}

	@Test(arguments: [
		(Decimal.zero, Rational.zero),
		(Decimal(1), Rational(1)),
		(Decimal(-1), Rational(-1)),
		(Decimal(1.25), Rational(5, 4)),
		(Decimal(-1.25), Rational(-5, 4)),
		(Decimal(UInt.max) * 2, Rational(BigInt(UInt.max) * 2)),
		(-Decimal(UInt.max) * 2, Rational(-BigInt(UInt.max) * 2)),
		(Decimal(UInt.max) + 25.5, Rational(BigInt("36893488147419103281"), BigInt(2))),
		(-Decimal(UInt.max) - 25.5, Rational(BigInt("-36893488147419103281"), BigInt(2))),
	])
	func initFromDecimalReduced(_ value: Decimal, _ expectation: Rational) throws {
		#expect(Rational(value)!.reduced === expectation)
	}
}
