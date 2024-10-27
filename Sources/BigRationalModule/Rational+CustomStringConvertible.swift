import BigInt

extension Rational: CustomStringConvertible {
	@inlinable
	public var description: String {
		guard isNaN == false else {
			return "NaN"
		}
		if denominator == 1 {
			return "\(sign)\(numerator)"
		} else {
			return "\(sign)\(numerator)/\(denominator)"
		}
	}
}

extension Rational: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		guard isNaN == false else {
			return "Rational(NaN)"
		}
		let n = String(reflecting: numerator)
		let d = String(reflecting: denominator)
		return "Rational(\(sign.debugDescription)\(n), \(d))"
	}
}

extension Rational.Sign: CustomStringConvertible {
	@inlinable
	public var description: String {
		switch self {
		case .negative:
			"-"
		case .zero, .positive:
			""
		}
	}
}

extension Rational.Sign: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		switch self {
		case .negative:
			"-"
		case .zero:
			""
		case .positive:
			"+"
		}
	}
}
