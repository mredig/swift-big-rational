import XCTest
import RationalModule

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

	func test_fraction_debug_string_conversion() throws {
		let r = Rational(1, 2)
		XCTAssertEqual(r.debugDescription, "Rational(1, 2)")
	}

	func test_fraction_negative_debug_string_conversion() throws {
		let r = Rational(-1, 2)
		XCTAssertEqual(r.debugDescription, "Rational(-1, 2)")
	}
}
