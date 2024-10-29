import BigInt

extension Rational: CustomStringConvertible {
	@inlinable
	public var description: String {
		makeDescription(alwaysShowSign: false)
	}

	@inlinable
	internal func makeDescription(asChild: Bool = false, alwaysShowSign: Bool) -> String {
		guard isNaN == false else {
			return "NaN"
		}
		let base = {
			guard
				sign == .negative || alwaysShowSign
			else { return "" }
			return "\(sign)"
		}()
		if isInteger && isSimplified && asChild == false {
			return base + "\(numerator)"
		} else {
			return base + "\(numerator)/\(denominator)"
		}
	}
}

extension Rational: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		"Rational(\(makeDescription(alwaysShowSign: true)))"
	}
}

extension Rational.Sign: CustomStringConvertible {
	@inlinable
	public var description: String {
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

extension Rational.Sign: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		description
	}
}
