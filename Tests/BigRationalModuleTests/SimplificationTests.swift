import Testing
import BigRationalModule

struct SimplificationTests {
	@Test(arguments: [
		Rational(2),
		Rational(1, 3),
		Rational(-2, 5),
		Rational(-5, 10),
		Rational.zero,
	])
	func isSimplified(_ value: Rational) throws {
		#expect(value.isSimplified)
	}

	@Test(arguments: [
		Rational(numerator: Rational(2), denominator: Rational(5)),
		Rational(numerator: (-3), denominator: (10)),
		Rational(Rational(2), 7),
		Rational(7, Rational(2)),
	])
	func isNotSimplified(_ value: Rational) throws {
		#expect(value.isSimplified == false)
	}

	@Test(
		arguments: [
			(
				Rational(numerator: Rational(2), denominator: Rational(5)),
				Rational(2, 5)
			),
			(Rational(1, 2), Rational(1, 2)),
			(
				Rational(Rational(3, 4), 4),
				Rational(3, 16)
			),
			(
				Rational(numerator: Rational(5, 10), denominator: Rational(10, 20)),
				Rational(100, 100)
			),
			(Rational(14, 49), Rational(14, 49)),
			(
				Rational(Rational(-12, 16), 2),
				Rational(-12, 32)
			),
			(
				Rational(numerator: Rational(6, -7), denominator: Rational(3, -21)),
				Rational(126, 21)
			),
			(
				Rational(numerator: Rational(-21, 14), denominator: Rational(9, -6)),
				Rational(126, 126)
			),
			(
				Rational(numerator: Rational(18, 27), denominator: Rational(-6, 9)),
				Rational(-162, 162)
			),
			(
				Rational(Rational(50, -75), 2),
				Rational(-50, 150)
			),
			(
				Rational(numerator: Rational(1000, 10000), denominator: Rational(-25, 100)),
				Rational(-100000, 250000)
			),

			(
				Rational(
					numerator: Rational(numerator: Rational(2, -6), denominator: Rational(3, -9)), // -18/-18
					denominator: Rational(-1, 4) // -72/18
				),
				Rational(-72, 18)
			),
			(
				Rational(
					numerator: Rational(-8, Rational(
						Rational(2, -4), 3) // 2/-12
					), // 96/2
					denominator: Rational(2, 1) // 96/4
				),
				Rational(96, 4)
			),
			(
				Rational(
					numerator: Rational(
						numerator: Rational(-5, 10),
						denominator: Rational(Rational(1, 3), 4) // 1/12
					), // -60/10
					denominator: Rational(1, 2) // -120/10
				),
				Rational(-120, 10)
			),
			(
				Rational(
					numerator: Rational(
						8,
						Rational(numerator: Rational(-4, 3), denominator: Rational(-2, 4)) // -16/-6
					), // 48/16
					denominator: Rational(-2, 1) // 48/-32
				),
				Rational(48, -32)
			),
			(
				Rational(
					numerator: Rational(9, Rational(
						Rational(-3, Rational(-27, 9)), // -27/-27
						2) // 27/54
					), // 486/27
					denominator: Rational(3, -1) // 486/-81
				),
				Rational(486, -81)
			)
		]
	)
	func simplify(_ input: Rational, expectation: Rational) throws {
		let simplified = input.simplified
		#expect(simplified === expectation)
	}

	@Test(
		arguments: [
			(
				Rational(numerator: Rational(2), denominator: Rational(5)),
				Rational(2, 5)
			),
			(Rational(1, 2), Rational(1, 2)),
			(
				Rational(Rational(3, 4), 4),
				Rational(3, 16)
			),
			(
				Rational(numerator: Rational(5, 10), denominator: Rational(10, 20)),
				Rational(1)
			),
			(Rational(14, 49), Rational(2, 7)),
			(
				Rational(Rational(-12, 16), 2),
				Rational(-3, 8)
			),
			(
				Rational(numerator: Rational(6, -7), denominator: Rational(3, -21)),
				Rational(6)
			),
			(
				Rational(numerator: Rational(-21, 14), denominator: Rational(9, -6)),
				Rational(1)
			),
			(
				Rational(numerator: Rational(18, 27), denominator: Rational(-6, 9)),
				Rational(-1)
			),
			(
				Rational(Rational(50, -75), 2),
				Rational(-1, 3)
			),
			(
				Rational(numerator: Rational(1000, 10000), denominator: Rational(-25, 100)),
				Rational(-2, 5)
			),
			(
				Rational(
					numerator: Rational(numerator: Rational(2, -6), denominator: Rational(3, -9)), // -18/-18
					denominator: Rational(-1, 4) // -72/18
				),
				Rational(-4)
			),
			(
				Rational(
					numerator: Rational(-8, Rational(
						Rational(2, -4), 3) // 2/-12
					), // 96/2
					denominator: Rational(2, 1) // 96/4
				),
				Rational(24)
			),
			(
				Rational(
					numerator: Rational(
						numerator: Rational(-5, 10),
						denominator: Rational(Rational(1, 3), 4) // 1/12
					), // -60/10
					denominator: Rational(1, 2) // -120/10
				),
				Rational(-12)
			),
			(
				Rational(
					numerator: Rational(
						8,
						Rational(numerator: Rational(-4, 3), denominator: Rational(-2, 4)) // -16/-6
					), // 48/16
					denominator: Rational(-2, 1) // 48/-32
				),
				Rational(3, -2)
			),
			(
				Rational(
					numerator: Rational(9, Rational(
						Rational(-3, Rational(-27, 9)), // -27/-27
						2) // 27/54
					), // 486/27
					denominator: Rational(3, -1) // 486/-81
				),
				Rational(-6)
			)
		]
	)
	func reduced(_ input: Rational, expectation: Rational) throws {
		let reduced = input.reduced
		#expect(reduced === expectation)
	}

	@Test func other() throws {
		let foo = Rational.init(-1)

		print(foo)
	}
}
