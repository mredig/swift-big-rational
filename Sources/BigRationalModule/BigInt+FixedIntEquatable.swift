import BigInt

public extension BigInt {
	static func == <N: FixedWidthInteger>(lhs: Self, rhs: N) -> Bool {
		rhs == lhs
	}
}

public extension FixedWidthInteger {
	static func == (lhs: Self, rhs: BigInt) -> Bool {
		BigInt(lhs) == rhs
	}
}
