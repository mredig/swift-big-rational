import Testing
import BigRationalModule
import BigInt
import Foundation

struct FloatTests {
	@Test(arguments: [
		(Decimal.zero, Rational.zero),
		(Decimal.nan, nil),
		(Decimal(1), Rational(1)),
		(Decimal(-1), Rational(-1)),
		(Decimal(1.25), Rational(125, 100)),
		(Decimal(-1.25), Rational(-125, 100)),
		(Decimal(UInt.max) * 2, Rational(big: BigInt(UInt.max) * 2)),
		(-Decimal(UInt.max) * 2, Rational(big: -BigInt(UInt.max) * 2)),
		(Decimal(UInt.max) + 25.5, Rational(BigInt("184467440737095516405"), BigInt(10))),
		(-Decimal(UInt.max) - 25.5, Rational(-BigInt("184467440737095516405"), BigInt(10))),
	])
	func initFromDecimalExact(_ value: Decimal, _ expectation: Rational?) throws {
		#expect(Rational(value) === expectation)
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
		( Double.nan, nil ),
		( Double(-1), Rational(-1) ),
		( Double(1.25), Rational(5, 4) ),
		( Double(-1.25), Rational(-5, 4) ),
		( Double(bitPattern: 0x3ff4000000000001), Rational(5629499534213121, 4503599627370496)),
		( Double.greatestFiniteMagnitude, Rational(big: BigInt(Double.greatestFiniteMagnitude)) ),
		( Double.leastNormalMagnitude, Rational(BigInt(1), BigInt("44942328371557897693232629769725618340449424473557664318357520289433168951375240783177119330601884005280028469967848339414697442203604155623211857659868531094441973356216371319075554900311523529863270738021251442209537670585615720368478277635206809290837627671146574559986811484619929076208839082406056034304")) ),
	])
	func initFromDouble(_ value: Double, _ expectation: Rational?) throws {
		#expect(Rational(truncating: value)?.reduced === expectation)
	}

	@Test(arguments: [
		( Float.zero, Rational.zero ),
		( Float(1), Rational(1) ),
		( Float.nan, nil ),
		( Float(-1), Rational(-1) ),
		( Float(1.25), Rational(5, 4) ),
		( Float(-1.25), Rational(-5, 4) ),
		( Float.greatestFiniteMagnitude, Rational(big: BigInt(Float.greatestFiniteMagnitude)) ),
		( Float.leastNormalMagnitude, Rational("1/85070591730234615865843651857942052864")! ),
	])
	func initFromFloat(_ value: Float, _ expectation: Rational?) throws {
		#expect(Rational(truncating: value)?.reduced === expectation)
	}

	@Test(arguments: [
		( Float16.zero, Rational.zero ),
		( Float16(1), Rational(1) ),
		( Float16.nan, nil ),
		( Float16(-1), Rational(-1) ),
		( Float16(1.25), Rational(5, 4) ),
		( Float16(-1.25), Rational(-5, 4) ),
		( Float16.greatestFiniteMagnitude, Rational(big: BigInt(Float16.greatestFiniteMagnitude)) ),
		( Float16.leastNormalMagnitude, Rational("1/16384")! ),
	])
	func initFromFloat16(_ value: Float16, _ expectation: Rational?) throws {
		#expect(Rational(truncating: value)?.reduced === expectation)
	}

	@Test(arguments: [
		( Rational.zero, Double.zero ),
		( Rational(1), Double(1) ),
		( Rational(-1), Double(-1) ),
		( Rational(5, 4), Double(1.25) ),
		( Rational(-5, 4), Double(-1.25) ),
		( Rational(125, 4), Double(31.25) ),
		( Rational((BigInt(5629499534213121) * 10000) + 1, BigInt(4503599627370496) * 10000), Double(bitPattern: 0x3ff4000000000001)),
		( Rational((BigInt(5629499534213121) * BigInt(10).power(309)) + 1, BigInt(4503599627370496) * BigInt(10).power(309)), Double(bitPattern: 0x3ff4000000000001)),
		( Rational(BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 3, BigInt(exactly: Decimal.greatestFiniteMagnitude)!), Double(3) ),
		( Rational(BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 5, BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 4), Double(1.25) ),
		( Rational((BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 5) + 1, BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 4), Double(1.25) ),
		( Rational(big: BigInt(Double.greatestFiniteMagnitude)), Double.greatestFiniteMagnitude ),
		( Rational(big: BigInt(-Double.greatestFiniteMagnitude)), -Double.greatestFiniteMagnitude ),
		( Rational(BigInt(1), BigInt("44942328371557897693232629769725618340449424473557664318357520289433168951375240783177119330601884005280028469967848339414697442203604155623211857659868531094441973356216371319075554900311523529863270738021251442209537670585615720368478277635206809290837627671146574559986811484619929076208839082406056034304")), Double.leastNormalMagnitude ),
	])
	func toDouble(_ value: Rational, _ expectation: Double) throws {
		#expect(value.doubleValue() == expectation)
	}

	@Test(arguments: [
		( Rational.zero, Float.zero ),
		( Rational(1), Float(1) ),
		( Rational(-1), Float(-1) ),
		( Rational(5, 4), Float(1.25) ),
		( Rational(-5, 4), Float(-1.25) ),
		( Rational(125, 4), Float(31.25) ),
		( Rational((BigInt(10485761) * 10000) + 1, BigInt(8388608) * 10000), Float(bitPattern: 0x3fa00001)),
		( Rational((BigInt(10485761) * BigInt(10).power(309)) + 1, BigInt(8388608) * BigInt(10).power(309)), Float(bitPattern: 0x3fa00001)),
		( Rational(BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 3, BigInt(exactly: Decimal.greatestFiniteMagnitude)!), Float(3) ),
		( Rational(BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 5, BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 4), Float(1.25) ),
		( Rational((BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 5) + 1, BigInt(exactly: Decimal.greatestFiniteMagnitude)! * 4), Float(1.25) ),
		( Rational(big: BigInt(Float.greatestFiniteMagnitude)), Float.greatestFiniteMagnitude ),
		( Rational(big: BigInt(-Float.greatestFiniteMagnitude)), -Float.greatestFiniteMagnitude ),
		( Rational(BigInt(1), BigInt("85070591730234615865843651857942052864")), Float.leastNormalMagnitude ),
	])
	func toFloat(_ value: Rational, _ expectation: Float) throws {
		#expect(Float(value) == expectation)
	}

}
