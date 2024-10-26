import BigInt

extension Rational: CustomStringConvertible {
	@inlinable
	public var description: String {
		if denominator == 1 {
			"\(sign)\(numerator)"
		} else {
			"\(sign)\(numerator)/\(denominator)"
		}
	}
}

extension Rational: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		let n = String(reflecting: numerator)
		let d = String(reflecting: denominator)
		return "Rational(\(sign)\(n), \(d))"
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
