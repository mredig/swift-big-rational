import Foundation
import Testing
import BigRationalModule

struct HashableTests {
	@Test func test_basic_hash_equatable() throws {
		let a = Rational("1/2")?.hashValue
		let b = Rational(1, 2).hashValue

		#expect(a == b)
		#expect(Set([a!, b]).count == 1)
	}

	@Test func test_unreduced_hash_equatable() throws {
		let a = Rational("1/2")?.hashValue
		let b = Rational(2, 4).hashValue

		#expect(a == b)
		#expect(Set([a!, b]).count == 1)
	}

	@Test func test_negative_hash_equatable() throws {
		let a = Rational("-1/2")?.hashValue
		let b = Rational(1, -2).hashValue

		#expect(a == b)
		#expect(Set([a!, b]).count == 1)
	}

	@Test func test_unreduced_negative2_hash_equatable() throws {
		let a = Rational("-1/2")?.hashValue
		let b = Rational(2, -4).hashValue

		#expect(a == b)
		#expect(Set([a!, b]).count == 1)
	}

	@Test func test_not_hash_equal() throws {
		let a = Rational("1/2")?.hashValue
		let b = Rational(3, 4).hashValue

		#expect(a != b)
		#expect(Set([a!, b]).count == 2)
	}

	@Test func signHashesCorrect() throws {
		let allCases: Set<Rational.Sign> = [.negative, .zero, .positive]

		#expect(allCases.count == 3)
	}
}
