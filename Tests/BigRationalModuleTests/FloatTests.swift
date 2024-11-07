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
		(Decimal(UInt.max) * 2, Rational(big: BigInt(UInt.max) * 2)),
		(-Decimal(UInt.max) * 2, Rational(big: -BigInt(UInt.max) * 2)),
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
		(Decimal(UInt.max) * 2, Rational(big: BigInt(UInt.max) * 2)),
		(-Decimal(UInt.max) * 2, Rational(big: -BigInt(UInt.max) * 2)),
		(Decimal(UInt.max) + 25.5, Rational(BigInt("36893488147419103281"), BigInt(2))),
		(-Decimal(UInt.max) - 25.5, Rational(BigInt("-36893488147419103281"), BigInt(2))),
	])
	func initFromDecimalReduced(_ value: Decimal, _ expectation: Rational) throws {
		#expect(Rational(value)!.reduced === expectation)
	}

	@Test(arguments: [
		( Double.zero, Rational.zero ),
		( Double(1), Rational(1) ),
		( Double(-1), Rational(-1) ),
		( Double(1.25), Rational(5, 4) ),
		( Double(-1.25), Rational(-5, 4) ),
		( Double.greatestFiniteMagnitude, Rational(big: BigInt(Double.greatestFiniteMagnitude)) ),
		( Double.leastNormalMagnitude, Rational(BigInt(1), BigInt("44942328371557897693232629769725618340449424473557664318357520289433168951375240783177119330601884005280028469967848339414697442203604155623211857659868531094441973356216371319075554900311523529863270738021251442209537670585615720368478277635206809290837627671146574559986811484619929076208839082406056034304")) ),
	])
	func initFromDouble(_ value: Double, _ expectation: Rational) throws {
		#expect(Rational(truncating: value)!.reduced === expectation)
	}
}
