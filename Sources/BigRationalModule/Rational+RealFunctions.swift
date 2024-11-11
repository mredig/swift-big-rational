import RealModule
import BigInt

extension Rational: RealFunctions {
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
		fatalError("\(#function) not implemented")
	}
	
	public static func gamma(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func log2(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func log10(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func logGamma(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func signGamma(_ x: Rational) -> FloatingPointSign {
		fatalError("\(#function) not implemented")
	}
	
	public static func _mulAdd(_ a: Rational, _ b: Rational, _ c: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func exp(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func expMinusOne(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
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
	
	public static func cos(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func sin(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func tan(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func log(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
	}
	
	public static func log(onePlus x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
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
		let max = BigUInt(Int.max)
		guard
			nthRoot < max,
			power < max
		else { return .nan }

		let step1 = root(x, Int(nthRoot))

		return pow(step1, Int(power))
	}
	
	public static func pow(_ x: Rational, _ n: Int) -> Rational {
		guard x.isNaN == false else { return .nan }

		guard n != 0 else { return 1 }
		guard n != 1 else { return x }
		guard n != -1 else { return x.getReciprocal() }

		var exponent = n

		var invert = false
		if exponent.signum() == -1 {
			exponent.negate()
			invert = true
		}

		var base = x

		let oddHandler: Rational
		if exponent.isMultiple(of: 2) {
			oddHandler = 1
		} else {
			oddHandler = x
			exponent -= 1
		}

		while exponent > 1 {
			base = base * base
			exponent /= 2
		}

		let final = oddHandler * base
		guard invert else {
			return final
		}
		return final.getReciprocal()
	}
	
	public static func sqrt(_ x: Rational) -> Rational {
		root(x, 2)
	}
	
	public static func root(_ base: Rational, _ degree: Int) -> Rational {
		var degree = degree
		guard degree != 0 else { return .nan }
		guard base.isZero == false else { return .zero }
		guard base.isNaN == false else { return .nan }
		guard base != 1 else { return 1 }

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
