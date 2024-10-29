import BigInt

public extension Rational {
	enum Storage: Sendable, Codable {
		case bigInt(BigInt)
		indirect case rational(Rational)

		public static func bigUInt(_ value: BigUInt) -> Storage {
			.bigInt(BigInt(value))
		}

		public var isZero: Bool {
			switch self {
			case .bigInt(let bigInt):
				bigInt == 0
			case .rational(let rational):
				rational.isZero
			}
		}

		public var isPositive: Bool {
			switch self {
			case .bigInt(let bigInt):
				bigInt.signum() == 1
			case .rational(let rational):
				rational.signum() == 1
			}
		}

		public var isNegative: Bool {
			switch self {
			case .bigInt(let bigInt):
				bigInt.signum() == -1
			case .rational(let rational):
				rational.signum() == -1
			}
		}

		public var isInteger: Bool {
			switch self {
			case .bigInt:
				true
			case .rational(let rational):
				rational.isInteger
			}
		}

		public var isNaN: Bool {
			switch self {
			case .bigInt:
				false
			case .rational(let rational):
				rational.isNaN
			}
		}
	}
}

extension Rational.Storage: Hashable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		switch (lhs, rhs) {
		case (.bigInt(let lBigInt), .bigInt(let rBigInt)):
			return lBigInt == rBigInt
		case (.bigInt(let a), .rational(let b)), (.rational(let b), .bigInt(let a)):
			guard b.isInteger else { return false }
			return a == b.reduced.simplifiedValues.numerator
		case (.rational(let lRat), .rational(let rRat)):
			return lRat == rRat
		}
	}

	public static func === (lhs: Self, rhs: Self) -> Bool {
		switch (lhs, rhs) {
		case (.bigInt(let lBigInt), .bigInt(let rBigInt)):
			lBigInt == rBigInt
		case (.rational(let lRat), .rational(let rRat)):
			lRat === rRat
		default: false
		}
	}

	public static func !== (lhs: Self, rhs: Self) -> Bool {
		!(lhs === rhs)
	}

	public static func == (lhs: Self, rhs: BigInt) -> Bool {
		lhs == .bigInt(rhs)
	}

	public static func != (lhs: Self, rhs: BigInt) -> Bool {
		lhs != .bigInt(rhs)
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(String(describing: Self.self))
		switch self {
		case .bigInt(let bigInt):
			hasher.combine(bigInt)
		case .rational(let rational):
			if rational.isInteger {
				hasher.combine(rational.reduced.simplifiedValues.numerator)
			} else {
				hasher.combine(rational)
			}
		}
	}

	public static func == <I: FixedWidthInteger>(lhs: Self, rhs: I) -> Bool {
		lhs == BigInt(rhs)
	}
}

extension Rational.Storage: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		let leftRat: Rational
		let rightRat: Rational
		switch (lhs, rhs) {
		case (.bigInt(let lBigInt), .bigInt(let rBigInt)):
			return lBigInt < rBigInt
		case (.bigInt(let a), .rational(let b)):
			leftRat = Rational(a)
			rightRat = b
		case (.rational(let a), .bigInt(let b)):
			leftRat = a
			rightRat = Rational(b)
		case (.rational(let lRat), .rational(let rRat)):
			leftRat = lRat
			rightRat = rRat
		}

		return leftRat < rightRat
	}
}

extension Optional where Wrapped == Rational.Storage {
	public static func == <I: FixedWidthInteger>(lhs: Self, rhs: I) -> Bool {
		switch lhs {
		case .some(let storage):
			storage == rhs
		case .none: false
		}
	}
}

extension Rational.Storage: CustomStringConvertible, CustomDebugStringConvertible {
	public var description: String {
		switch self {
		case .bigInt(let bigInt):
			bigInt.description
		case .rational(let rational):
			"(\(rational.makeDescription(asChild: true, alwaysShowSign: false)))"
		}
	}

	public var debugDescription: String {
		"Rational.Storage\(description)"
	}
}
