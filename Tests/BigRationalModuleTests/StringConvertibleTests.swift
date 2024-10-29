import Testing
import BigRationalModule

struct StringConvertibleTests {
	@Test func testFractionStringConversion() throws {
		let r = Rational(1, 2)
		#expect(r.description == "1/2")
	}

	@Test func testIntegerStringConversion() throws {
		let r = Rational(1, 1)
		#expect(r.description == "1")
	}

	@Test func testNegativeIntegerStringConversion() throws {
		let r = Rational(-1, 1)
		#expect(r.description == "-1")
	}

	@Test func testNanStringConversion() throws {
		let nans = [
			Rational.nan,
			Rational(0, 0)
		]
		for nanValue in nans {
			#expect(nanValue.description == "NaN")
		}
	}

	@Test func testFractionDebugStringConversion() throws {
		let r = Rational(1, 2)
		#expect(r.debugDescription == "Rational(+1, 2)")
	}

	@Test func testFractionNegativeDebugStringConversion() throws {
		let r = Rational(-1, 2)
		#expect(r.debugDescription == "Rational(-1, 2)")
	}

	@Test func testZeroDebugStringConversion() throws {
		let r = Rational(0)
		#expect(r.debugDescription == "Rational(0, 1)")
	}

	@Test func testNanDebugStringConversion() throws {
		let nans = [
			Rational.nan,
			Rational(0, 0)
		]
		for nanValue in nans {
			#expect(nanValue.debugDescription == "Rational(NaN)")
		}
	}
}
