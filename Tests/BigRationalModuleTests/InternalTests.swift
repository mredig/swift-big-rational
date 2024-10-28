import Foundation
import Testing
@testable import BigRationalModule

struct InternalTests {
	@Test(arguments: [
		(1, 2, 0),
		(2, 2, 1),
		(2, 1, 2),
		(-1, 2, -1),
		(-2, 2, -1),
		(-2, 1, -2),
		(1, -2, -1),
		(2, -2, -1),
		(2, -1, -2),
		(-1, -2, 0),
		(-2, -2, 1),
		(-2, -1, 2),
		(0, 1, 0),
		(0, -1, 0),
		(3, 4, 0),
		(4, 4, 1),
		(4, 3, 1),
		(-3, 4, -1),
		(-4, 4, -1),
		(-4, 3, -2),
		(3, -4, -1),
		(4, -4, -1),
		(4, -3, -2),
		(-3, -4, 0),
		(-4, -4, 1),
		(-4, -3, 1),
		(1, 4, 0),
		(4, 4, 1),
		(4, 1, 4),
		(-1, 4, -1),
		(-4, 4, -1),
		(-4, 1, -4),
		(1, -4, -1),
		(4, -4, -1),
		(4, -1, -4),
		(-1, -4, 0),
		(-4, -4, 1),
		(-4, -1, 4),
	])
	func floorDivision(args: (a: Int, b: Int, expectation: Int)) throws {
		let (a, b, expectation) = args
		#expect(BigRationalModule.floorDivision(a, b) == expectation)
	}
}
