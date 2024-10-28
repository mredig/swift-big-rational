import BigInt

extension Rational: Equatable {
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		func reducedEqual(lhs: Self, rhs: Self) -> Bool {
			lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator && lhs.sign == rhs.sign
		}

		let a = lhs.reduced
		let b = rhs.reduced
		return reducedEqual(lhs: a, rhs: b)
	}

	@inlinable
	public static func === (lhs: Self, rhs: Self) -> Bool {
		guard lhs.sign == rhs.sign else { return false }
		return lhs.numerator === rhs.numerator && lhs.denominator === rhs.denominator
	}

	@inlinable
	public static func !== (lhs: Self, rhs: Self) -> Bool {
		!(lhs === rhs)
	}
}

extension Rational: Hashable {
	@inlinable
	public func hash(into hasher: inout Hasher) {
		guard isNaN == false else {
			hasher.combine(0 as BigInt)
			hasher.combine(0 as BigInt)
			hasher.combine(Rational.Sign.zero)
			return
		}

		let reduced = reduced
		hasher.combine(reduced.numerator)
		hasher.combine(reduced.denominator)
		hasher.combine(reduced.sign)
	}
}
