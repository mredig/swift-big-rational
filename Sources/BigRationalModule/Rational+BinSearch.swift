import BigInt

package extension Rational {
	typealias BinarySearchDeterminer = (Rational) -> BSComparator
	enum BSComparator {
		case lessThan
		case match
		case greaterThan
	}
	private static let bigUintMax = BigUInt(UInt.max)

	func binarySearch(_ block: BinarySearchDeterminer, range: ClosedRange<Rational>, maxIterations: Int = 100) -> Rational {
		func getMiddle(from range: ClosedRange<Rational>) -> Rational {
			let rangeDiff = range.upperBound - range.lowerBound
			return (rangeDiff / 2) + range.lowerBound
		}

		var range = range
		for i in 0..<maxIterations {
			let middle = getMiddle(from: range)

			guard
				middle.isNaN == false,
				middle.isZero == false,
				middle.denominator.isZero == false
			else { return middle }
			let result = block(middle)

			switch result {
			case .greaterThan:
				let lower = {
					let value = range.lowerBound.limitDenominator(to: Self.bigUintMax)
					guard
						value != range.lowerBound,
						block(value) == .lessThan
					else { return range.lowerBound }
					return value
				}()

				let upper = {
					let middleAlt = middle.limitDenominator(to: Self.bigUintMax)
					guard
						middleAlt != middle,
						block(middleAlt) == .greaterThan
					else { return middle }
					return middleAlt
				}()

				guard lower != upper else { fatalError("bad binary search - got greater than with 0 range span") }
				range = lower...upper
			case .match:
				return middle
			case .lessThan:
				let lower = {
					let middleAlt = middle.limitDenominator(to: Self.bigUintMax)
					guard
						middleAlt != middle,
						block(middleAlt) == .lessThan
					else { return middle }
					return middleAlt
				}()

				let upper = {
					let value = range.upperBound.limitDenominator(to: Self.bigUintMax)
					guard
						value != range.upperBound,
						block(value) == .greaterThan
					else { return range.upperBound }
					return value
				}()

				guard upper != lower else { fatalError("bad binary search - got less than with 0 range span") }
				range = lower...upper
			}
		}
		return getMiddle(from: range).limitDenominator(to: Self.bigUintMax)
	}

	func squareRoot() -> Rational {
		guard isZero == false else { return .zero }
		guard isNaN == false, isNegative == false else { return .nan }
		guard self != 1 else { return 1 }

		let range: ClosedRange<Rational>
		if self > 1 {
			if self.isInteger, self.reduced.simplifiedValues.numerator.isMultiple(of: 2) {
				range = 0...self
			} else {
				range = 1...self
			}
		} else {
			range = 0...1
		}

		return binarySearch({ test in
			let result = test * test
			if result == self {
				return .match
			} else if result > self {
				return .greaterThan
			} else {
				return .lessThan
			}
		}, range: range)
	}
