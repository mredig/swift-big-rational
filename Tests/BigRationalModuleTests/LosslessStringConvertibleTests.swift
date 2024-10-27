import Testing
import BigInt
import BigRationalModule

struct LosslessStringConvertibleTests {
	@Test func test_2_returns_2_over_1() throws {
		let r = Rational("2")
		#expect(r != nil)
		#expect(r?.numerator == 2)
		#expect(r?.denominator == 1)
	}

	@Test func test_2_over_4_returns_2_over_4_when_not_reduced_by_default() throws {
		let r = Rational("2/4")
		#expect(r != nil)
		#expect(r?.numerator == 2)
		#expect(r?.denominator == 4)
	}

	@Test func test_2_over_4_returns_1_over_2() throws {
		let r = Rational("2/4", reduced: true)
		#expect(r != nil)
		#expect(r?.numerator == 1)
		#expect(r?.denominator == 2)
	}

	@Test func test_whitespace_returns_nil() throws {
		let r = Rational("2 / 3")
		#expect(r == Rational(2, 3))
	}

	@Test func test_missing_denominator_returns_nil() throws {
		let r = Rational("2/")
		#expect(r == nil)
	}

	@Test func test_division_by_0_returns_nil() throws {
		let r = Rational("1/0")
		#expect(r == .nan)
	}

	@Test func test_multiple_slash_returns_nil() throws {
		let r = Rational("1/5/2")
		#expect(r == nil)
	}

	@Test func wouldOverflow64BitIntegers() throws { // (but doesn't here)
		let r = Rational("1844674407370955161500 / 18446744073709551615000")
		let bigNumerator = BigInt("1844674407370955161500")
		let bigDenominator = BigInt("18446744073709551615000")
		#expect(r == Rational(bigNumerator, bigDenominator))
	}

	@Test func ignoreUnderscores() throws {
		let r = Rational("1_844_674_407_370_955_161_500 / 184_4674_40_73_709_551_615_000")
		let bigNumerator = BigInt("1844674407370955161500")
		let bigDenominator = BigInt("18446744073709551615000")
		#expect(r == Rational(bigNumerator, bigDenominator))
	}

	@Test func invalidCharacterReturnsNil() throws {
		let r = Rational("5 / s")
		#expect(r == nil)
	}

	@Test func binary() throws {
		let r = Rational("1001 / 100001", radix: 2)
		#expect(r == Rational(9, 33))
	}

	@Test func binaryWithPrefix() throws {
		let r = Rational("0b1001 / 0b100001", radix: 2)
		#expect(r == Rational(9, 33))
	}

	@Test func binaryInvalidReturnsNil() throws {
		let r = Rational("1001 / 100021", radix: 2)
		#expect(r == nil)
	}

	@Test func hex() throws {
		let r = Rational("f5 / 5f5", radix: 16)
		#expect(r == Rational(245, 1525))
	}

	@Test func hexWithPrefix() throws {
		let r = Rational("0xf5 / 0x5f5", radix: 16)
		#expect(r == Rational(245, 1525))
	}

	@Test func hexWithPrefix2() throws {
		let r = Rational("f5 / 0x5f5", radix: 16)
		#expect(r == Rational(245, 1525))
	}

	@Test func hexInvalidReturnsNil() throws {
		let r = Rational("f5z / 5f5", radix: 16)
		#expect(r == nil)
	}

}
