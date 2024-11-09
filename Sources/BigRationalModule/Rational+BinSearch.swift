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
			let firstResult = block(middle)

			guard firstResult != .match else { return middle }

			let simplerMiddle = {
				if i.isMultiple(of: 2) {
					middle.limitDenominator(to: Self.bigUintMax)
				} else {
					Rational(truncating: middle.doubleValue()) ?? middle.limitDenominator(to: Self.bigUintMax)
				}
			}()
			let secondResult = {
				guard simplerMiddle != middle else { return firstResult }
				return block(simplerMiddle)
			}()
			guard secondResult != .match else { return simplerMiddle }

			switch firstResult {
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
					guard secondResult == .greaterThan else { return middle }
					return simplerMiddle
				}()

				if i > maxIterations / 2, let getDesperate = flail(block, startValue: upper, startingComparison: .greaterThan) {
					return getDesperate
				}

				guard lower != upper else { fatalError("bad binary search - got greater than with 0 range span") }
				range = lower...upper
			case .match:
				return middle
			case .lessThan:
				let lower = {
					guard secondResult == .lessThan else { return middle }
					return simplerMiddle
				}()

				let upper = {
					let value = range.upperBound.limitDenominator(to: Self.bigUintMax)
					guard
						value != range.upperBound,
						block(value) == .greaterThan
					else { return range.upperBound }
					return value
				}()

				if i > maxIterations / 2, let getDesperate = flail(block, startValue: lower, startingComparison: .lessThan) {
					return getDesperate
				}

				guard upper != lower else { fatalError("bad binary search - got less than with 0 range span") }
				range = lower...upper
			}
		}
		return getMiddle(from: range).limitDenominator(to: Self.bigUintMax)
	}

	// desperate attempt at honing in on a solid answer
	private func flail(_ block: BinarySearchDeterminer, startValue: Rational, startingComparison: BSComparator) -> Rational? {
		var value = startValue.reduced
		let isProperFraction = value.isProperFraction

		let positiveFlail: StrideThrough<BigInt> = stride(from: 1, through: 10, by: 1)
		let negativeFlail: StrideThrough<BigInt> = stride(from: -1, through: -10, by: -1)

		let numeratorFlailStride: StrideThrough<BigInt>
		let denominatorFlailStride: StrideThrough<BigInt>

		switch startingComparison {
		case .lessThan:
			numeratorFlailStride = positiveFlail
			denominatorFlailStride = negativeFlail
		case .match:
			return startValue
		case .greaterThan:
			numeratorFlailStride = negativeFlail
			denominatorFlailStride = positiveFlail
		}

		func numeratorModifier(_ input: Rational, relativeAdjustment: BigInt) -> Rational? {
			let simple = input.simplifiedValues
			let num = simple.numerator
			let den	= simple.denominator
			let newNumerator = BigInt(num) + relativeAdjustment
			guard newNumerator.sign == .plus else { return nil }
			return Rational(numerator: .bigUInt(newNumerator.magnitude), denominator: .bigUInt(den), sign: value.sign)
		}

		func denominatorModifier(_ input: Rational, relativeAdjustment: BigInt) -> Rational? {
			let simple = input.simplifiedValues
			let num = simple.numerator
			let den	= simple.denominator
			let newDenominator = BigInt(den) + relativeAdjustment
			guard newDenominator.sign == .plus else { return nil }
			return Rational(numerator: .bigUInt(num), denominator: .bigUInt(newDenominator.magnitude), sign: value.sign)
		}

		typealias ValueModifier = (Rational, BigInt) -> Rational?
		typealias ValueModStride = (modifier: ValueModifier, stride: StrideThrough<BigInt>)
		let order: (first: ValueModStride, second: ValueModStride)
		if isProperFraction {
			order = ((denominatorModifier, denominatorFlailStride), (numeratorModifier, numeratorFlailStride))
		} else {
			order = ((numeratorModifier, numeratorFlailStride), (denominatorModifier, denominatorFlailStride))
		}

		var tValue = value
		for relativeAdjustment in order.first.stride {
			guard
				let newValue = order.first.modifier(tValue, relativeAdjustment)
			else { break }
			tValue = newValue
			let result = block(tValue)
			if result == .match {
				return tValue
			} else if result != startingComparison {
				break
			}
		}
		return nil
	}
}
