import Testing
import BigRationalModule
import BigInt
import Foundation

struct IntegerLiteralTests {
	@Test func literal2Returns2Over1() throws {
		let r: Rational = 2
		#expect(r.numerator == 2)
		#expect(r.denominator == 1)
	}

	@Test func initFromBigUInt() throws {
		let new = Rational(big: 1234, sign: .positive)
		#expect(new == Rational.bigUInt(1234, 1, sign: .positive))
	}

	@Test func initNegativeFromBigUInt() throws {
		let new = Rational(big: 1234, sign: .negative)
		#expect(new == Rational.bigUInt(1234, 1, sign: .negative))
	}

	@Test func initExactlyFromBinaryInteger() throws {
		let new = Rational(exactly: 1234)
		#expect(new == Rational.bigUInt(1234, 1, sign: .positive))
	}

	@Test func scratch() throws {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 64
		formatter.minimumFractionDigits = 64

		let double = Double.random(in: -100...100)
		for i in 0..<16 {
//			print(formatter.string(from: double as NSNumber) ?? "no value")
			let value = Decimal(double).nextUp * pow(10, i)
//			print(value)
//			print(formatter.string(from: value as NSDecimalNumber) ?? "no value")
//			print(value.formatted(.number.precision(.significantDigits(38))))

			let rat = Rational(value)

			let pointer = UnsafeMutablePointer<Decimal>.allocate(capacity: 1)
			pointer.initialize(to: 0)
			pointer.pointee = value
			defer { pointer.deallocate() }
			let altString = NSDecimalString(pointer, NSLocale(localeIdentifier: "en_US"))
			print(altString)
			print(rat ?? .zero)
			print(rat?.reduced ?? .zero)

			print("exponent: \(value.exponent)")
			print("significand: \(value.significand)")
			print("ulp: \(value.ulp)")
			print("decimalCount: \(decimalCount(for: value))")

//			let base = Rational(BigInt((value.significand as NSNumber).intValue))
//			let ulppy = pow(10, -(value.exponent))
//			let mult = Rational.oneOver(BigInt((ulppy as NSNumber).intValue))
//			let comb = base * mult
//			print(comb)
			print()
		}
	}

	func decimalCount(for decimal: Decimal) -> Int {
		max(-decimal.exponent, 0)
	}
}
