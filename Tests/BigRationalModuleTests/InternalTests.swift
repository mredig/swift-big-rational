import Foundation
import Testing
@testable import BigRationalModule
import BigInt

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
		(-4, -3, 1),
		(1, 4, 0),
		(4, 1, 4),
		(-1, 4, -1),
		(-4, 1, -4),
		(1, -4, -1),
		(4, -1, -4),
		(-1, -4, 0),
		(-4, -4, 1),
		(-4, -1, 4),
	])
	func floorDivision(args: (a: Int, b: Int, expectation: Int)) throws {
		let (a, b, expectation) = args
		#expect(BigRationalModule.floorDivision(a, b) == expectation)
	}

	@Test(arguments: [
		(1, 0, 1),
		(0, 1, 1),
		(112975790, 764306440, 10),
		(-632361076, 451917501, 1),
		(97920124, 163870524, 4),
		(932508, 35847, 9),
		(384377, 42427, 7),
		(-1, -1, 1),
		(1, -1, 1),
		(39, 52, 13),
		(80, 20, 20),
		(2, 4, 2),
		(-2, -4, 2),
	])
	func greatestCommonDivisor(_ a: BigInt, _ b: BigInt, expectation: Int) throws {
		#expect(gcd(a, b) == expectation)
	}
}
