import XCTest
import BigRationalModule

final class StrideableTests: XCTestCase {
	func test_stride_0_to_1_step_1_over_4() throws {
		let values: [Rational] = Array(stride(from: 0, to: 1, by: .init(1, 4)))
		XCTAssertEqual(values, [0, .init(1, 4), .init(1, 2), .init(3, 4)])
	}

	func test_stride_0_through_1_step_1_over_4() throws {
		let values: [Rational] = Array(stride(from: 0, through: 1, by: .init(1, 4)))
		XCTAssertEqual(values, [0, .init(1, 4), .init(1, 2), .init(3, 4), 1])
	}

	func test_distance_between_consecutive_values_equals_step() throws {
		let values: [Rational] = [0, .init(1, 4), .init(1, 2), .init(3, 4), 1]
		for i in 1..<values.endIndex {
			XCTAssertEqual(values[i - 1].distance(to: values[i]), Rational(1, 4))
		}
	}
}
