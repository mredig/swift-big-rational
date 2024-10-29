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
		Rational(Rational(2), Rational(5)),
		Rational(Rational(-3), Rational(10)),
		Rational(Rational(2), 7),
		Rational(7, Rational(2)),
	])
	func isNotSimplified(_ value: Rational) throws {
		#expect(value.isSimplified == false)
	}

	@Test(
		arguments: [
			(
				Rational(Rational(2), Rational(5)),
				Rational(2, 5)
			),
			(Rational(1, 2), Rational(1, 2)),
			(
				Rational(Rational(3, 4), 4),
				Rational(3, 16)
			),
			(
				Rational(Rational(5, 10), Rational(10, 20)),
				Rational(100, 100)
			),
			(Rational(14, 49), Rational(14, 49)),
			(
				Rational(Rational(-12, 16), 2),
				Rational(-12, 32)
			),
			(
				Rational(Rational(6, -7), Rational(3, -21)),
				Rational(126, 21)
			),
			(
				Rational(Rational(-21, 14), Rational(9, -6)),
				Rational(126, 126)
			),
			(
				Rational(Rational(18, 27), Rational(-6, 9)),
				Rational(-162, 162)
			),
			(
				Rational(Rational(50, -75), 2),
				Rational(-50, 150)
			),
			(
				Rational(Rational(1000, 10000), Rational(-25, 100)),
				Rational(-100000, 250000)
			),

			(
				Rational(
					Rational(Rational(2, -6), Rational(3, -9)), // -18/-18
					Rational(-1, 4) // -72/18
				),
				Rational(-72, 18)
			),
			(
				Rational(
					Rational(-8, Rational(
						Rational(2, -4), 3) // 2/-12
					), // 96/2
					Rational(2, 1) // 96/4
				),
				Rational(96, 4)
			),
			(
				Rational(
					Rational(
						Rational(-5, 10),
						Rational(Rational(1, 3), 4) // 1/12
					), // -60/10
					Rational(1, 2) // -120/10
				),
				Rational(-120, 10)
			),
			(
				Rational(
					Rational(
						8,
						Rational(Rational(-4, 3), Rational(-2, 4)) // -16/-6
					), // 48/16
					Rational(-2, 1) // 48/-32
				),
				Rational(48, -32)
			),
			(
				Rational(
					Rational(9, Rational(
						Rational(-3, Rational(-27, 9)), // -27/-27
						2) // 27/54
					), // 486/27
					Rational(3, -1) // 486/-81
				),
				Rational(486, -81)
			)

		]
	)
	func simplify(_ input: Rational, expectation: Rational) throws {
		let simplified = input.simplified
		#expect(simplified === expectation)
	}


	@Test func other() throws {
		let foo = Rational(
			Rational(-8, Rational(
				Rational(2, -4), 3) // 2 / -12
			), // 96 / 2
			Rational(2, 1) // 96/4
		)
	}
}
