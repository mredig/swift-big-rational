import RealModule
import BigInt
#if canImport(Foundation)
import Foundation
#endif

extension Rational: RealFunctions {
	#if canImport(Foundation)
	// Swift 6 might have some locks or something now? That's probably preferred.
	private static let lock = NSLock()
	#endif
	nonisolated(unsafe) private static var _trigPrecision = Rational(1, big: .uIntMax)
	#if canImport(Foundation)
	nonisolated(unsafe) public static var trigPrecision: Rational {
		get { lock.withLock { _trigPrecision } }
		set { lock.withLock { _trigPrecision = newValue } }
	}
	#else
	nonisolated(unsafe) public static var trigPrecision: Rational {
		get { _trigPrecision }
		set { _trigPrecision = newValue }
	}
	#endif

	public static func atan2(y: Rational, x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func erf(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func erfc(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func exp2(_ x: Rational) -> Rational {
		pow(2, x)
	}
	
	public static func exp10(_ x: Rational) -> Rational {
		pow(10, x)
	}
	
	public static func hypot(_ x: Rational, _ y: Rational) -> Rational {
		sqrt((x * x) + (y * y))
	}
	
	public static func gamma(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func log2(_ x: Rational) -> Rational {
		let startLog = log(x)
		return startLog / .ln2
	}
	
	public static func log10(_ x: Rational) -> Rational {
		let startLog = log(x)
		return startLog / .ln10
	}
	
	public static func logGamma(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func signGamma(_ x: Rational) -> FloatingPointSign {
		fatalError("\(#function) not implemented")
	}
	
	public static func _mulAdd(_ a: Rational, _ b: Rational, _ c: Rational) -> Rational {
		(a * b) + c
	}
	
	public static func exp(_ x: Rational) -> Rational {
		pow(e, x)
	}
	
	public static func expMinusOne(_ x: Rational) -> Rational {
		exp(x) - 1
	}
	
	public static func cosh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func sinh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func tanh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}

	public static func taylorSeries(
		term: Rational,
		precision: Rational,
		startIteration: Int,
		iterationModifier: (Int) -> Int = { $0 + 1 },
		termModifier: (Rational, Int) -> Rational,
		valueForResult: (Rational, Int) -> Rational = { term, _ in term }
	) -> Rational {
		var term = term
		var result = term
		var difference = Rational(10)
		var iteration = startIteration

		while difference > precision {
			iteration = iterationModifier(iteration)
			term = termModifier(term, iteration)
			let term1 = valueForResult(term, iteration)
			result += term1
			difference = abs(term1)
		}

		return result
	}

	public static func cos(_ x: Rational) -> Rational {
		guard x.isNaN == false else { return .nan }
		let corrected = x % (.pi * 2)

		let negCorrectedSquared = -(corrected * corrected)

		return taylorSeries(
			term: 1,
			precision: Self.trigPrecision,
			startIteration: 0,
			iterationModifier: { $0 + 2 },
			termModifier: { term, iteration in
				term * (negCorrectedSquared / (iteration * (iteration - 1)))
			})
	}

	public static func sin(_ x: Rational) -> Rational {
		guard x.isNaN == false else { return .nan }
		let corrected = x % (.pi * 2)

		let negCorrectedSquared = -(corrected * corrected)

		return taylorSeries(
			term: corrected,
			precision: Self.trigPrecision,
			startIteration: 1,
			iterationModifier: { $0 + 2 },
			termModifier: { term, iteration in
				term * (negCorrectedSquared / (iteration * (iteration - 1)))
			})
	}
	
	public static func tan(_ x: Rational) -> Rational {
		sin(x) / cos(x)
	}

	public static func computeTaylorSeriesLog(
		_ x: Rational,
		precision: Rational = Rational(1, big: .uIntMax)
	) -> Rational {
		guard x.isNegative == false else { return .nan }
		func compute(x: Rational) -> Rational {
			taylorSeries(
				term: x - 1,
				precision: precision,
				startIteration: 1,
				termModifier: { term, _ in term * -(x - 1) },
				valueForResult: { term, i in term / i })
		}

		var input = x
		guard input > 0 else { return .nan }

		var j = 0
		let twoThreshold = Rational(2)
		while input > twoThreshold {
			input /= twoThreshold
			j += 1
		}
		while input < 1 {
			input *= twoThreshold
			j -= 1
		}

		var k = 0
		let threshold = Rational(3, 2)
		while input > threshold {
			input /= threshold
			k += 1
		}
		// I believe it's mathematically impossible to end up in this block, so I'm commenting it.
		// However, I'm leaving as a comment in case I'm wrong.
//		while input < 1 {
//			input *= threshold
//			k -= 1
//		}

		let part = compute(x: input)
		// *mathematically*, we COULD just use `part + ln(1.5)*k + ln(2)*j`,
		// but this is used to avoid circular dependencies on the dynamically generated constants.
		switch (j, k) {
		case (0, 0):
			return part
		case (let j, 0):
			return part + (Self.ln2 * j)
		case (0, let k):
			return part + (Self.lnOneAndHalf * k)
		default:
			return part + (Self.lnOneAndHalf * k) + (Self.ln2 * j)
		}
	}

	public static func log(_ x: Rational) -> Rational {
		computeTaylorSeriesLog(x)
	}
	
	public static func log(onePlus x: Rational) -> Rational {
		log(x + 1)
	}

	public static func acosh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func asinh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func atanh(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func acos(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func asin(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func atan(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func pow(_ x: Rational, _ y: Rational) -> Rational {
		guard x.isNaN == false else { return .nan }

		guard y.isZero == false else { return 1 }
		guard y != 1 else { return x }
		guard y != -1 else { return x.getReciprocal() }

		let simplifiedValues = y.simplifiedValues
		let power = simplifiedValues.numerator
		let nthRoot = simplifiedValues.denominator

		let step1 = root(x, BigInt(nthRoot))

		let subfinal = pow(step1, BigInt(power))
		if y.isNegative {
			return subfinal.getReciprocal()
		} else {
			return subfinal
		}
	}

	public static func pow(_ x: Rational, _ n: Int) -> Rational {
		pow(x, BigInt(n))
	}

	public static func pow(_ x: Rational, _ n: BigInt) -> Rational {
		guard x.isNaN == false else { return .nan }

		guard n != 0 else { return 1 }
		guard n != 1 else { return x }
		guard n != -1 else { return x.getReciprocal() }
		guard x.isZero == false else {
			if n < 1 {
				return .nan
			} else {
				return .zero
			}
		}

		var exponent = n
		var result: Rational = 1
		var currentBase = x

		var invert = false
		if exponent.signum() == -1 {
			exponent.negate()
			invert = true
		}

		while exponent > 0 {
			if exponent.isMultiple(of: 2) == false {
				result = result * currentBase
			}
			currentBase = currentBase * currentBase
			exponent /= 2
		}

		guard invert else {
			return result
		}
		return result.getReciprocal()
	}
	
	public static func sqrt(_ x: Rational) -> Rational {
		root(x, 2)
	}

	public static func root(_ base: Rational, _ degree: Int) -> Rational {
		root(base, BigInt(degree))
	}

	public static func root(_ base: Rational, _ degree: BigInt) -> Rational {
		var degree = degree
		guard degree != 0 else { return .nan }
		guard base.isZero == false else { return .zero }
		guard base.isNaN == false else { return .nan }
		guard base != 1 else { return 1 }
		guard degree != 1 else { return base }

		let isNegative = base.isNegative
		var base = base
		if isNegative {
			guard degree.isMultiple(of: 2) == false else { return .nan }
			base.negate()
		}
		var invert = false
		if degree.signum() == -1 {
			degree.negate()
			invert = true
		}

		guard base.isInteger else {
			let numeratorRooted = root(Rational(numerator: base.numerator, denominator: .bigUInt(1), sign: .positive), degree)
			let denominatorRooted = root(Rational(numerator: base.denominator, denominator: .bigUInt(1), sign: .positive), degree)

			var subfinal = Rational(numerator: numeratorRooted, denominator: denominatorRooted, reduced: true)
			if isNegative {
				subfinal.negate()
			}
			if invert {
				subfinal = subfinal.getReciprocal()
			}
			return subfinal
		}

		let range: ClosedRange<Rational>
		if base.reduced.simplifiedValues.numerator.isMultiple(of: 2) {
			range = 0...base
		} else {
			range = 1...base
		}

		var subfinal = base.binarySearch(
			{ test in
				let result = Rational.pow(test, degree)
				if result == base {
					return .match
				} else if result > base {
					return .greaterThan
				} else {
					return .lessThan
				}
			},
			range: range)

		if isNegative {
			subfinal.negate()
		}
		if invert {
			subfinal = subfinal.getReciprocal()
		}
		return subfinal
	}
}
