import XCTest
import BigRationalModule

final class StringConvertibleTests: XCTestCase {
	func test_fraction_string_conversion() throws {
		let r = Rational(1, 2)
		XCTAssertEqual(r.description, "1/2")
	}

	func test_integer_string_conversion() throws {
		let r = Rational(1, 1)
		XCTAssertEqual(r.description, "1")
	}

	func test_negative_integer_string_conversion() throws {
		let r = Rational(-1, 1)
		XCTAssertEqual(r.description, "-1")
	}

	func test_nan_string_conversion() throws {
		let nans = [
			Rational.nan,
			Rational(0, 0)
		]
		for nanValue in nans {
			XCTAssertEqual(nanValue.description, "NaN")
		}
	}
	func test_fraction_debug_string_conversion() throws {
		let r = Rational(1, 2)
		XCTAssertEqual(r.debugDescription, "Rational(+1, 2)")
	}

	func test_fraction_negative_debug_string_conversion() throws {
		let r = Rational(-1, 2)
		XCTAssertEqual(r.debugDescription, "Rational(-1, 2)")
	}

	func test_zero_debug_string_conversion() throws {
		let r = Rational(0)
		XCTAssertEqual(r.debugDescription, "Rational(0, 1)")
	}
	func test_nan_debug_string_conversion() throws {
		let nans = [
			Rational.nan,
			Rational(0, 0)
		]
		for nanValue in nans {
			XCTAssertEqual(nanValue.debugDescription, "Rational(NaN)")
		}
	}
}
