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
		#expect(r.debugDescription == "Rational(+1/2)")
	}

	@Test func testFractionNegativeDebugStringConversion() throws {
		let r = Rational(-1, 2)
		#expect(r.debugDescription == "Rational(-1/2)")
	}

	@Test func testZeroDebugStringConversion() throws {
		let r = Rational(0)
		#expect(r.debugDescription == "Rational(0)")
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

	@Test(
		arguments: [
			(
				Rational(numerator: Rational(2), denominator: Rational(5)),
				"(2/1)/(5/1)"
			),
			(Rational(1, 2), "1/2"),
			(
				Rational(Rational(3, 4), 4),
				"(3/4)/4"
			),
			(
				Rational(numerator: Rational(5, 10), denominator: Rational(10, 20)),
				"(5/10)/(10/20)"
			),
			(Rational(14, 49), "14/49"),
			(
				Rational(Rational(-12, 16), 2),
				"(-12/16)/2"
			),
			(
				Rational(numerator: Rational(6, -7), denominator: Rational(3, -21)),
				"(-6/7)/(-3/21)"
			),
			(
				Rational(numerator: Rational(-21, 14), denominator: Rational(9, -6)),
				"(-21/14)/(-9/6)"
			),
			(
				Rational(numerator: Rational(18, 27), denominator: Rational(-6, 9)),
				"(18/27)/(-6/9)"
			),
			(
				Rational(Rational(50, -75), 2),
				"(-50/75)/2"
			),
			(
				Rational(numerator: Rational(1000, 10000), denominator: Rational(-25, 100)),
				"(1000/10000)/(-25/100)"
			),
			(
				Rational(
					numerator: Rational(numerator: Rational(2, -6), denominator: Rational(3, -9)), // -18/-18
					denominator: Rational(-1, 4) // -72/18
				),
				"((-2/6)/(-3/9))/(-1/4)"
			),
			(
				Rational(
					numerator: Rational(-8, Rational(
						Rational(2, -4), 3) // 2/-12
					), // 96/2
					denominator: Rational(2, 1) // 96/4
				),
				"(-8/((-2/4)/3))/(2/1)"
			),
			(
				Rational(
					numerator: Rational(
						numerator: Rational(-5, 10),
						denominator: Rational(Rational(1, 3), 4) // 1/12
					), // -60/10
					denominator: Rational(1, 2) // -120/10
				),
				"((-5/10)/((1/3)/4))/(1/2)"
			),
			(
				Rational(
					numerator: Rational(
						8,
						Rational(numerator: Rational(-4, 3), denominator: Rational(-2, 4)) // -16/-6
					), // 48/16
					denominator: Rational(-2, 1) // 48/-32
				),
				"(8/((-4/3)/(-2/4)))/(-2/1)"
			),
			(
				Rational(
					numerator: Rational(9, Rational(
						Rational(-3, Rational(-27, 9)), // -27/-27
						2) // 27/54
					), // 486/27
					denominator: Rational(3, -1) // 486/-81
				),
				"(9/((-3/(-27/9))/2))/(-3/1)"
			)
		]
	)
	func complexDescriptions(_ rational: Rational, _ expected: String) throws {
		#expect(rational.description == expected)
	}
}
