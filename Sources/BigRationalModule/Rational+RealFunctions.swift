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
		fatalError("\(#function) not implemented")
	}
	
	public static func exp10(_ x: Rational) -> Rational {
		fatalError("\(#function) not implemented")
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
		fatalError("\(#function) not implemented")
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
		guard x.isZero == false else { return .zero }
		guard x.isNaN == false, x.isNegative == false else { return .nan }
		guard x != 1 else { return 1 }

		guard x.isInteger else {
			let numeratorSquare = sqrt(Rational(numerator: x.numerator, denominator: .bigUInt(1), sign: .positive))
			let denominatorSquare = sqrt(Rational(numerator: x.denominator, denominator: .bigUInt(1), sign: .positive))

			return Rational(numerator: numeratorSquare, denominator: denominatorSquare, reduced: true)
		}

		let range: ClosedRange<Rational>
		if x.reduced.simplifiedValues.numerator.isMultiple(of: 2) {
			range = 0...x
		} else {
			range = 1...x
		}

		return x.binarySearch(
			{ test in
				let result = test * test
				if result == x {
					return .match
				} else if result > x {
					return .greaterThan
				} else {
					return .lessThan
				}
			},
			range: range)
	}
	
	public static func root(_ x: Rational, _ n: Int) -> Rational {
		fatalError("\(#function) not implemented")
	}
}
