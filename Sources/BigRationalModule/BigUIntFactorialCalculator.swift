import BigInt

public struct BigUIntFactorialCalculator {
	private var cache: [BigUInt: BigUInt] = [:]
	private var highestCachedValue: BigUInt = 1

	public init() {}

	mutating public func factorial(of input: BigUInt) -> BigUInt {
		guard input != 0, input != 1 else { return 1 }

		func calculate(previous: BigUInt, input: BigUInt) -> BigUInt {
			let new = previous * input
			cache[input] = new
			highestCachedValue = max(input, highestCachedValue)
			return new
		}

		if let cached = cache[input] {
			return cached
		} else if let previous = cache[input - 1] {
			return calculate(previous: previous, input: input)
		}

		var prev: BigUInt = 0
		for i in highestCachedValue..<input {
			prev = factorial(of: i)
		}

		return calculate(previous: prev, input: input)
	}
}
