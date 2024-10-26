import BigInt

public struct Rational: Sendable, Codable, Hashable {
	/// The numerator of this value.
	public let numerator: BigInt

	/// The denominator of this value.
	public let denominator: BigInt

	public let sign: Sign

	public typealias T = BigInt

	public enum Sign: Sendable, Hashable, Codable {
		case negative
		case zero
		case positive

		@inlinable
		public static func multiplicationOutput(lhs: Sign, rhs: Sign) -> Sign {
			switch (lhs, rhs) {
			case (.negative, .negative), (.positive, .positive), (.positive, .zero), (.zero, .positive):
				.positive
			case (.zero, .zero):
				.zero
			default:
				.negative
			}
		}

		@inlinable
		public init<N: SignedInteger>(_ value: N) {
			switch value {
				case 0:
					self = .zero
				case 1...:
					self = .positive
				default:
					self = .negative
				}
		}
	}

	/// Creates a rational value with the given numerator and denominator.
	@inlinable
	internal init(numerator: T, denominator: T, sign: Sign) {
		assert(denominator != 0, "The denominator must not be 0")

		self.numerator = numerator
		self.denominator = denominator
		self.sign = sign
	}
}

// MARK: - Initializers
extension Rational {
	/// Creates a rational value from a fraction of integers.
	///
	/// The result is normalized so that the numerator and denominator
	/// have no common factors and the denominator is positive.
	///
	///     Rational(2, 4)     // 1/2
	///     Rational(2, 2)     // 1
	///     Rational(1, -3)    // -1/3
	///     Rational(6, 3)     // 2
	///
	/// - Precondition: `denominator != 0`
	@inlinable
	public init(_ numerator: BigInt, _ denominator: BigInt, reduced: Bool = false) {
		precondition(denominator != 0, "The denominator must not be zero")

		let numSign = Sign(numerator)
		let denSign = Sign(denominator)
		let sign = Sign.multiplicationOutput(lhs: numSign, rhs: denSign)

		self.init(numerator: numerator, denominator: denominator, sign: sign)
		if reduced {
			self = self.reduced
		}
	}

	@inlinable
	public init<N: FixedWidthInteger>(_ numerator: N, _ denominator: N, reduced: Bool = false) {
		let num = BigInt(numerator)
		let den = BigInt(denominator)
		self.init(num, den, reduced: reduced)
	}
}

// MARK: - Properties
extension Rational {
	/// The quotient of the numerator divided by the denominator.
	@inlinable
	public var quotient: T {
		numerator / denominator
	}

	/// The remainder of the numerator divided by the denominator.
	@inlinable
	public var remainder: T {
		numerator % denominator
	}

	/// The quotient and remainder of the numerator divided by the denominator.
	@inlinable
	public var quotientAndRemainder: (quotient: T, remainder: T) {
		numerator.quotientAndRemainder(dividingBy: denominator)
	}

	/// A copy of this value where the denominator is always positive.
//	@inlinable
//	public var normalizedSign: Self {
//		var numerator = numerator
//		var denominator = denominator
//		if denominator < 0 {
//			denominator.negate()
//			numerator.negate()
//		}
//		return Self(numerator: numerator, denominator: denominator)
//	}

	@inlinable
	public var isSignNormalized: Bool {
		denominator > 0
	}

	/// Whether or not this value is equal to `0`.
	@inlinable
	public var isZero: Bool {
		numerator == 0
	}

	/// Whether or not this value is negative.
	@inlinable
	public var isNegative: Bool {
//		normalizedSign.numerator < 0
		sign == .negative
	}

	/// Whether or not this value is positive.
	@inlinable
	public var isPositive: Bool {
//		normalizedSign.numerator > 0
		sign == .positive
	}

	/// An equal copy of this value, but where the components are a reduced fraction.
	@inlinable
	public var reduced: Self {
		guard numerator != denominator else {
			return Self(numerator: 1, denominator: 1, sign: sign)
		}

		guard numerator != 0 else {
			return Self(numerator: 0, denominator: 1, sign: .zero)
		}

		let g = gcd(numerator, denominator)
		let numerator = numerator / g
		let denominator = denominator / g

		return Self(numerator: numerator, denominator: denominator, sign: sign)
	}

	/// An equal copy of this value, but where the components are a reduced fraction with a positive denominator.
//	@inlinable
//	public var normalized: Self {
//		reduced.normalizedSign
//	}

	/// Whether or not this value represents an integer.
	@inlinable
	public var isInteger: Bool {
		reduced.denominator == 1
	}

	/// Whether or not the magnitude of this value is less than `1`.
	@inlinable
	public var isProperFraction: Bool {
		numerator.magnitude < denominator.magnitude
	}
}

// MARK: - Helpers
extension Rational {
	/// Returns `-1` if this value is negative and `1` if it's positive;
	/// otherwise, `0`.
	@inlinable
	public func signum() -> T {
		switch sign {
		case .negative: -1
		case .zero: 0
		case .positive: 1
		}
	}

	/// Returns the numerator and denominator as a tuple.
	@inlinable
	public func toRatio() -> (numerator: T, denominator: T) {
		(numerator, denominator)
	}

	/// Returns the closest rational number to this value
	/// with a denominator at most `max`.
	///
	/// - Precondition: `max >= 1`
	@inlinable
	public func limitDenominator(to max: T) -> Self {
		precondition(max >= 1, "The value of `max` should be at least 1")

		guard denominator > max else { return self }

		var p0: T = 0
		var q0: T = 1
		var p1: T = 1
		var q1: T = 0
		var n = numerator
		var d = denominator

		while true {
			let a = floorDivision(n, d)
			let q2 = q0 + a * q1
			guard q2 <= max else { break }

			(p0, q0, p1, q1) = (p1, q1, p0 + a * p1, q2)
			(n, d) = (d, n - a * d)
		}

		let k = floorDivision((max - q0), q1)
		return if 2 * d * (q0 + k * q1) <= denominator {
			Self(numerator: p1, denominator: q1, sign: sign)
		} else {
			Self(numerator: p0 + k * p1, denominator: q0 + k * q1, sign: sign)
		}
	}
}

/// Equivalent to Python's `//` operator.
@usableFromInline
internal func floorDivision<T: BinaryInteger>(_ a: T, _ b: T) -> T {
	let quotient = a / b
	return if a >= 0 {
		quotient
	} else {
		quotient - 1
	}
}

// MARK: - Rounding
extension Rational {
	/// The greatest integer less than or equal to this value.
	@inlinable
	public var floor: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient - 1
		} else {
			quotient
		}
	}

	/// The smallest integer greater than or equal to this value.
	@inlinable
	public var ceil: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient
		} else {
			quotient + 1
		}
	}

	/// The closest integer to this value, or the one with
	/// greater magnitude if two values are equally close.
	@inlinable
	public var rounded: T {
		guard !isInteger else { return numerator }
		// If the magnitude of the fractional part
		// is less than 1/2, round towards zero.
		//
		// |r|    1
		// --- < --- => 2 * |r| < |d|
		// |d|    2
		return if 2 * remainder.magnitude < denominator.magnitude {
			quotient
		} else {
			roundedAwayFromZero
		}
	}

	/// The closest integer whose magnitude is greater than
	/// or equal to this value.
	@inlinable
	public var roundedAwayFromZero: T {
		guard !isInteger else { return numerator }
		return if isNegative {
			quotient - 1
		} else {
			quotient + 1
		}
	}
}
