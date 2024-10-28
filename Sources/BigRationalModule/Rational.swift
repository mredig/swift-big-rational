import BigInt

public struct Rational: Sendable, Codable {
	/// The numerator of this value.
	public let numerator: BigInt

	/// The denominator of this value.
	public let denominator: BigInt

	public let sign: Sign

	public var isNaN: Bool { denominator == 0 }

	public static let nan = Rational(numerator: 0, denominator: 0, sign: .zero)

	public enum Sign: BigInt, Sendable, Hashable, Codable {
		case negative = -1
		case zero = 0
		case positive = 1

		@inlinable
		public static func multiplicationOutput(lhs: Sign, rhs: Sign) -> Sign {
			switch (lhs, rhs) {
			case (.negative, .negative), (.positive, .positive):
				.positive
			case (.zero, .zero), (_, .zero), (.zero, _):
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

		@inlinable
		public var opposite: Sign {
			switch self {
			case .negative:
					.positive
			case .zero:
					.zero
			case .positive:
					.negative
			}
		}
	}

	@inlinable
	internal init(numerator: Storage, denominator: Storage, sign: Sign) {
		fatalError()
	}

	/// Creates a rational value with the given numerator and denominator.
	@inlinable
	internal init(numerator: BigInt, denominator: BigInt, sign: Sign) {
		guard
			denominator != 0
		else {
			self.denominator = 0
			self.numerator = 0
			self.sign = .zero
			return
		}

		self.numerator = numerator
		self.denominator = denominator
		guard numerator != 0 else {
			self.sign = .zero
			return
		}
		self.sign = sign
	}
}

// MARK: - Initializers
extension Rational {
	/// Creates a rational value from a fraction of integers.
	///
	///     Rational(2, 4)     // 2/4
	///     Rational(2, 4, reduced: true)     // 1/2
	///     Rational(2, 2)     // 2/2
	///     Rational(1, -3)    // -1/3
	///     Rational(6, 3, reduced: true)     // 2
	///
	/// - Precondition: `denominator != 0`
	@inlinable
	public init(_ numerator: BigUInt, _ denominator: BigUInt, sign: Sign = .positive, reduced: Bool = false) {
		self.init(numerator: BigInt(numerator), denominator: BigInt(denominator), sign: sign)
		guard reduced else { return }
		self = self.reduced
	}

	@inlinable
	public init<SN: SignedInteger>(_ numerator: SN, _ denominator: SN, reduced: Bool = false) {
		let numSign = Sign(numerator)
		let denSign = Sign(denominator)
		let sign = Sign.multiplicationOutput(lhs: numSign, rhs: denSign)

		self.init(BigUInt(numerator.magnitude), BigUInt(denominator.magnitude), sign: sign, reduced: reduced)
		guard reduced else { return }
		self = self.reduced
	}
}

// MARK: - Properties
extension Rational {
	/// The quotient of the numerator divided by the denominator.
	@inlinable
	public var quotient: BigInt {
		(numerator / denominator) * sign.rawValue
	}

	/// The remainder of the numerator divided by the denominator.
	@inlinable
	public var remainder: BigInt {
		(numerator % denominator) * sign.rawValue
	}

	/// The quotient and remainder of the numerator divided by the denominator.
	@inlinable
	public var quotientAndRemainder: (quotient: BigInt, remainder: BigInt) {
		let result = numerator.quotientAndRemainder(dividingBy: denominator)
		return (result.quotient * sign.rawValue, result.remainder * sign.rawValue)
	}

	/// Whether or not this value is equal to `0`.
	@inlinable
	public var isZero: Bool {
		numerator == 0 && isNaN == false
	}

	/// Whether or not this value is negative.
	@inlinable
	public var isNegative: Bool {
		sign == .negative
	}

	/// Whether or not this value is positive.
	@inlinable
	public var isPositive: Bool {
		sign == .positive
	}

	/// An equal copy of this value, but where the components are a reduced fraction.
	@inlinable
	public var reduced: Self {
		guard isNaN == false else { return .nan }

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
	public func signum() -> BigInt {
		sign.rawValue
	}

	/// Returns the numerator and denominator as a tuple.
	@inlinable
	public func toRatio() -> (numerator: BigInt, denominator: BigInt) {
		(numerator, denominator)
	}

	/// Returns the closest rational number to this value
	/// with a denominator at most `max`.
	///
	/// - Precondition: `max >= 1`
	@inlinable
	public func limitDenominator(to max: BigUInt) -> Self {
		guard max != 0 else { return .nan }
		let max = BigInt(max)

		guard denominator > max else { return self }

		var p0: BigInt = 0
		var q0: BigInt = 1
		var p1: BigInt = 1
		var q1: BigInt = 0
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
	let remainder = a % b

	guard remainder != 0 else { return quotient }
	switch (a.signum(), b.signum()) {
	case (-1, -1), (1, 1):
		return quotient
	default:
		return quotient - 1
	}
}

// MARK: - Rounding
extension Rational {
	/// The greatest integer less than or equal to this value.
	@inlinable
	public var floor: BigInt {
		guard !isInteger else { return numerator * sign.rawValue }
		return if isNegative {
			quotient - 1
		} else {
			quotient
		}
	}

	/// The smallest integer greater than or equal to this value.
	@inlinable
	public var ceil: BigInt {
		guard !isInteger else { return numerator * sign.rawValue }
		return if isNegative {
			quotient
		} else {
			quotient + 1
		}
	}

	/// The closest integer to this value, or the one with
	/// greater magnitude if two values are equally close.
	@inlinable
	public var rounded: BigInt {
		guard !isInteger else { return numerator * sign.rawValue }
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
	public var roundedAwayFromZero: BigInt {
		guard !isInteger else { return numerator * sign.rawValue }
		return if isNegative {
			quotient - 1
		} else {
			quotient + 1
		}
	}
}
