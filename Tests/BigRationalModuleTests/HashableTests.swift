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

	@Test func nanHashEqual() throws {
		let a = Rational.nan.hashValue
		let b = Rational.nan.hashValue
		let c = Rational(5, 0, sign: .positive).hashValue

		#expect(a == b)
		#expect(a == c)
		#expect(b == c)
		#expect(b == a)
		#expect(c == a)
		#expect(c == b)
	}

	@Test func signHashesCorrect() throws {
		let allCases: Set<Rational.Sign> = [.negative, .zero, .positive]

		#expect(allCases.count == 3)
	}
}
