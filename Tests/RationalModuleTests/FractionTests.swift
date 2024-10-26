import Testing
import RationalModule

struct FractionTests {
	@Test func test_2_over_4_returns_2_over_4_when_not_reduced_by_default() throws {
		let r = Rational(2, 4)
		#expect(r.numerator == 2)
		#expect(r.denominator == 4)
	}

	@Test func test_2_over_4_reduced_returns_1_over_2() throws {
		let r = Rational(2, 4, reduced: true)
		#expect(r.numerator == 1)
		#expect(r.denominator == 2)
	}

	@Test func test_2_over_2_returns_2_over_2_when_not_reduced_by_default() throws {
		let r = Rational(2, 2)
		#expect(r.numerator == 2)
		#expect(r.denominator == 2)
	}

	@Test func test_2_over_2_reduced_returns_1_over_1() throws {
		let r = Rational(2, 2, reduced: true)
		#expect(r.numerator == 1)
		#expect(r.denominator == 1)
	}

	@Test func test_1_over_negative_3_returns_negative_1_over_3() throws {
		let r = Rational(1, -3)
		#expect(r.numerator == 1)
		#expect(r.denominator == 3)
		#expect(r.sign == .negative)
	}

	@Test func test_6_over_3_returns_6_over_3_when_not_reduced_by_default() throws {
		let r = Rational(6, 3)
		#expect(r.numerator == 6)
		#expect(r.denominator == 3)
	}

	@Test func test_6_over_3_reduced_returns_2_over_1() throws {
		let r = Rational(6, 3, reduced: true)
		#expect(r.numerator == 2)
		#expect(r.denominator == 1)
	}

	@Test func test_0_over_int_min_returns_0_over_int_min_mag() throws {
		let r = Rational(0, Int.min)
		#expect(r.numerator == 0)
		#expect(r.denominator == Int.min.magnitude)
		#expect(r.sign == .zero)
	}

	@Test func test_0_over_int_min_returns_0_over_int_min_magnitude() throws {
		let r = Rational(0, Int.min)
		#expect(r.numerator == 0)
		#expect(r.denominator == Int.min.magnitude)
	}

	@Test func test_int_min_over_int_min_returns_int_min_over_int_min_when_not_reduced_by_default() throws {
		let r = Rational(Int.min, Int.min)
		#expect(r.numerator == Int.min.magnitude)
		#expect(r.denominator == Int.min.magnitude)
		#expect(r.sign == .positive)
	}

	@Test func test_int_min_over_int_min_reduced_returns_1_over_1() throws {
		let r = Rational(Int.min, Int.min, reduced: true)
		#expect(r.numerator == 1)
		#expect(r.denominator == 1)
	}

	@Test func test_int_min_over_negative_two_returns_negative_int_min_over_two() throws {
		let r = Rational(Int.min, -2)
		#expect(r.numerator == Int.min.magnitude)
		#expect(r.denominator == 2)
	}

	@Test func test_int_min_over_negative_four_reduced_returns_negative_int_min_over_4() throws {
		let r = Rational(Int.min, -4, reduced: true)
		#expect(r.numerator == Int.min.magnitude / 4)
		#expect(r.denominator == 1)
	}
}
