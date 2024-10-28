import BigInt

public extension Rational {
	enum Storage: Sendable, Codable {
		case bigInt(BigInt)
		case rational(Rational)

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
	}
}

extension Rational.Storage: Hashable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		switch (lhs, rhs) {
		case (.bigInt(let lBigInt), .bigInt(let rBigInt)):
			lBigInt == rBigInt
		case (.bigInt(let a), .rational(let b)), (.rational(let b), .bigInt(let a)):
			Rational(a) == b
		case (.rational(let lRat), .rational(let rRat)):
			lRat == rRat
		}
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
			hasher.combine(Rational(bigInt))
		case .rational(let rational):
			hasher.combine(rational)
		}
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
