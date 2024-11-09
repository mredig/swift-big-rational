import BigInt

/// A numerical type to represent and calculate rational values. If math isn't your strong suit, it just means "fractions".
///
/// There's a lot of things to document here, but something that is somewhat notable is how equatability works.
///
/// `==` and `!=` determine if the represented value is the same, so `1/2 == 2/4`, for example. However,
/// despite `Rational` being a struct and not a class, it has the `===` operator implemented. In this case,
/// it means "identical". So, for example, `1/2 === 1/2`, but `1/2 !== 2/4`. It extends to embedded
/// `Rational`s so `(1/3)/4 === (1/3)/4`, and `(1/3)/4 !== (1/3)/(4/1)`, despite them having
/// the same value, once simplified. However, `===` does NOT mean that these values have the same address
/// memory! It simply indicates they have the same value AND composition, as opposed to just value.
public struct Rational: Sendable, Codable {
	/// The numerator of this value.
	public let numerator: Storage

	/// The denominator of this value.
	public let denominator: Storage

	public let sign: Sign

	public struct Simplified: Sendable, Hashable, Codable {
		// There's no valdation on this type, so it's only available in package.
		// Be sure to always provide valid values.
		public let numerator: BigUInt
		public let denominator: BigUInt
		public let sign: Sign

		@inlinable
		package init(_ numerator: BigUInt, _ denominator: BigUInt, sign: Sign) {
			self.numerator = numerator
			self.denominator = denominator
			self.sign = sign
		}
	}

	public var isNaN: Bool {
		numerator.isNaN ||
		denominator.isNaN ||
		denominator.isZero
	}

	public static let nan = Rational(numerator: 0 as BigUInt, denominator: 0 as BigUInt, sign: .zero)

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
		public init<N: SignedNumeric & Comparable>(_ value: N) {
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
		guard
			denominator.isZero == false
		else {
			self.denominator = .bigUInt(0)
			self.numerator = .bigUInt(0)
			self.sign = .zero
			return
		}

		self.numerator = numerator
		self.denominator = denominator
		guard numerator.isZero == false else {
			self.sign = .zero
			return
		}
		self.sign = sign
	}

	/// Creates a rational value with the given numerator and denominator.
	@inlinable
	internal init(numerator: BigUInt, denominator: BigUInt, sign: Sign) {
		self.init(numerator: .bigUInt(numerator), denominator: .bigUInt(denominator), sign: sign)
	}

	/// Creates a rational value with the given numerator and denominator.
	@inlinable
	internal init(numerator: BigInt, denominator: BigInt, sign: Sign) {
		self.init(numerator: .bigUInt(numerator.magnitude), denominator: .bigUInt(denominator.magnitude), sign: sign)
	}

	/// Creates a rational value with the given numerator and denominator.
	@inlinable
	internal init(autoSign numerator: BigInt, denominator: BigInt) {
		let sign = Sign.multiplicationOutput(lhs: Sign(numerator), rhs: Sign(denominator))
		self.init(
			numerator: .bigUInt(numerator.magnitude),
			denominator: .bigUInt(denominator.magnitude),
			sign: sign)
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
	///     Rational(6, 0)     // NaN
	///
	@inlinable
	public static func bigUInt(_ numerator: BigUInt, _ denominator: BigUInt, sign: Sign = .positive, reduced: Bool = false) -> Self {
		let new = Rational(numerator: .bigUInt(numerator), denominator: .bigUInt(denominator), sign: sign)
		guard reduced else { return new }
		return new.reduced
	}

	@inlinable
	public init<SN: SignedInteger>(_ numerator: SN, _ denominator: SN, reduced: Bool = false) {
		let numSign = Sign(numerator)
		let denSign = Sign(denominator)
		let sign = Sign.multiplicationOutput(lhs: numSign, rhs: denSign)

		let new = Rational.bigUInt(BigUInt(numerator.magnitude), BigUInt(denominator.magnitude), sign: sign, reduced: reduced)
		guard reduced else {
			self = new
			return
		}
		self = new.reduced
	}

	@_disfavoredOverload
	@inlinable
	public init(numerator: Rational, denominator: Rational, reduced: Bool = false) {
		self.init(numerator: .rational(numerator), denominator: .rational(denominator), sign: .positive)
		guard reduced else { return }
		self = self.reduced
	}

	@inlinable
	public init(big numerator: BigInt, _ denominator: Rational, reduced: Bool = false) {
		let sign = Sign(numerator)
		let numerator = numerator.magnitude
		self.init(numerator: .bigUInt(numerator), denominator: .rational(denominator), sign: sign)
		guard reduced else { return }
		self = self.reduced
	}

	@inlinable
	public init(_ numerator: Rational, big denominator: BigInt, reduced: Bool = false) {
		let sign = Sign(denominator)
		let denominator = denominator.magnitude
		self.init(numerator: .rational(numerator), denominator: .bigUInt(denominator), sign: sign)
		guard reduced else { return }
		self = self.reduced
	}

	/// Creates a `Rational` equal to `1/value`. Obviously, `value` must not be `0`.
	///
	/// Example:
	/// `Rational.oneOver(1234) // 1/1234`
	/// `Rational.oneOver(0) // NaN`
	@inlinable
	public static func oneOver(_ value: BigInt) -> Rational {
		Rational(autoSign: 1, denominator: value)
	}

	/// Creates a `Rational` equal to `1/value`. Obviously, `value` must not be `0`.
	///
	/// Example:
	/// `Rational.oneOver(1234) // 1/1234`
	/// `Rational.oneOver(0) // NaN`
	@inlinable
	public static func oneOver(_ value: BigUInt) -> Rational {
		Rational(numerator: .bigUInt(1), denominator: .bigUInt(value), sign: .positive)
	}

	/// Creates a `Rational` equal to `1/value`. Obviously, `value` must not be `0`.
	///
	/// Example:
	/// `Rational.oneOver(Rational(5, 6)) // 1/(5/6))`
	/// `Rational.oneOver(Rational(-7, 8)) // 1/(-7/8))`
	/// `Rational.oneOver(0) // NaN`
	@inlinable
	public static func oneOver(_ value: Rational) -> Rational {
		Rational(numerator: .bigUInt(1), denominator: .rational(value), sign: .positive)
	}

	/// Creates a `Rational` equal to `1`, but with a value of `value/value`. Obviously, `value` must be greater than `0`.
	///
	/// Example:
	/// `Rational.identityFraction(of: 1234) // 1234/1234`
	/// `Rational.identityFraction(of: 0) // NaN`
	@inlinable
	public static func identityFraction(of value: BigInt) -> Rational {
		Rational(autoSign: value, denominator: value)
	}

	/// Creates a `Rational` equal to `1`, but with a value of `value/value`. Obviously, `value` must be greater than `0`.
	///
	/// Example:
	/// `Rational.identityFraction(of: 1234) // 1234/1234`
	/// `Rational.identityFraction(of: 0) // NaN`
	@inlinable
	public static func identityFraction(of value: Rational) -> Rational {
		Rational(numerator: .rational(value), denominator: .rational(value), sign: .positive)
	}
}

// MARK: - Properties
extension Rational {
	@inlinable
	public var simplified: Rational {
		let simplifiedValues = simplifiedValues
		return Rational(numerator: simplifiedValues.numerator, denominator: simplifiedValues.denominator, sign: simplifiedValues.sign)
	}

	@inlinable
	public var isSimplified: Bool {
		guard
			case (.bigUInt, .bigUInt) = (numerator, denominator)
		else { return false }
		return true
	}

	@inlinable
	public var simplifiedValues: Simplified {
		switch (numerator, denominator) {
		case (.bigUInt(let num), .bigUInt(let den)):
			return Simplified(num, den, sign: sign)
		case (.rational(let topRational), .bigUInt(let intVal)):
			let simple = topRational * Rational.oneOver(intVal) * sign.rawValue
			return simple.simplifiedValues
		case (.bigUInt(let bigUInt), .rational(let bottomRational)):
			let simple = Rational(big: bigUInt, sign: .positive) * bottomRational.getReciprocal() * sign.rawValue
			return simple.simplifiedValues
		case (.rational(let topRational), .rational(let bottomRational)):
			let simple = topRational * bottomRational.getReciprocal() * sign.rawValue
			return simple.simplifiedValues
		}
	}

	/// The quotient of the numerator divided by the denominator.
	@inlinable
	public var quotient: BigInt {
		let simplified = self.simplifiedValues
		return BigInt(simplified.numerator / simplified.denominator) * simplified.sign.rawValue
	}

	/// The remainder of the numerator divided by the denominator.
	@inlinable
	public var remainder: BigInt {
		let simplified = self.simplifiedValues
		return BigInt(simplified.numerator % simplified.denominator) * simplified.sign.rawValue
	}

	/// The quotient and remainder of the numerator divided by the denominator.
	@inlinable
	public var quotientAndRemainder: (quotient: BigInt, remainder: BigInt) {
		let simplified = simplified.simplifiedValues
		let result = simplified.numerator.quotientAndRemainder(dividingBy: simplified.denominator)
		return (BigInt(result.quotient) * sign.rawValue, BigInt(result.remainder) * sign.rawValue)
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
			return Self(numerator: 1 as BigUInt, denominator: 1 as BigUInt, sign: sign)
		}

		guard numerator.isZero == false else {
			return Self(numerator: 0 as BigUInt, denominator: 1 as BigUInt, sign: .zero)
		}

		let simplifiedValues = simplified.simplifiedValues

		let g = gcd(simplifiedValues.numerator, simplifiedValues.denominator)
		let numerator = simplifiedValues.numerator / g
		let denominator = simplifiedValues.denominator / g

		return Self(numerator: numerator, denominator: denominator, sign: simplifiedValues.sign)
	}

	/// Whether or not this value represents an integer.
	@inlinable
	public var isInteger: Bool {
		reduced.denominator == 1
	}

	/// Whether or not the magnitude of this value is less than `1`.
	@inlinable
	public var isProperFraction: Bool {
		guard
			isSimplified
		else { return false }
		let simplifiedValues = simplified.simplifiedValues
		return simplifiedValues.numerator < simplifiedValues.denominator
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
		let simplifiedValues = simplifiedValues
		return (BigInt(simplifiedValues.numerator), BigInt(simplifiedValues.denominator))
	}

	/// Returns the closest rational number to this value
	/// with a denominator at most `max`.
	///
	/// - Precondition: `max >= 1`
	@inlinable
	public func limitDenominator(to max: BigUInt) -> Self {
		guard max != 0 else { return .nan }
		let max = BigInt(max)

		let simplifiedValues = simplifiedValues
		guard simplifiedValues.denominator > max else { return self }

		var p0: BigInt = 0
		var q0: BigInt = 1
		var p1: BigInt = 1
		var q1: BigInt = 0
		var n = BigInt(simplifiedValues.numerator)
		var d = BigInt(simplifiedValues.denominator)

		while true {
			let a = floorDivision(n, d)
			let q2 = q0 + a * q1
			guard q2 <= max else { break }

			(p0, q0, p1, q1) = (p1, q1, p0 + a * p1, q2)
			(n, d) = (d, n - a * d)
		}

		let k = floorDivision((max - q0), q1)
		return if 2 * d * (q0 + k * q1) <= BigInt(simplifiedValues.denominator) {
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
		guard !isInteger else { return BigInt(simplifiedValues.numerator) * sign.rawValue }
		return if isNegative {
			quotient - 1
		} else {
			quotient
		}
	}

	/// The smallest integer greater than or equal to this value.
	@inlinable
	public var ceil: BigInt {
		guard !isInteger else { return BigInt(simplifiedValues.numerator) * sign.rawValue }
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
		guard !isInteger else { return BigInt(simplifiedValues.numerator) * sign.rawValue }
		// If the magnitude of the fractional part
		// is less than 1/2, round towards zero.
		//
		// |r|    1
		// --- < --- => 2 * |r| < |d|
		// |d|    2
		let simplifiedValues = simplifiedValues
		return if 2 * remainder.magnitude < simplifiedValues.denominator {
			quotient
		} else {
			roundedAwayFromZero
		}
	}

	/// The closest integer whose magnitude is greater than
	/// or equal to this value.
	@inlinable
	public var roundedAwayFromZero: BigInt {
		guard !isInteger else { return BigInt(simplifiedValues.numerator) * sign.rawValue }
		return if isNegative {
			quotient - 1
		} else {
			quotient + 1
		}
	}
}
