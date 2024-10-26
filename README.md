# Swift Big Rational

## Introduction

Swift Big Rational provides the `BigRationalModule` module for working with rational numbers with fraction components that might normally overflow in Swift.
```swift
import BigRationalModule

let half = Rational(1, 2)
let tooBig = Rational(UInt.max) * Rational(4, 3)
```

It was forked from [Swift Rational](https://github.com/abdel-17/swift-rational) and amended to accommodate numbers beyond what fits in 64 bits and also allow control over whether fractions are reduced or not.

`BigRationalModule` has only two dependencies, [swift-numerics](https://github.com/apple/swift-numerics/tree/main) and [BigInt](https://github.com/attaswift/BigInt).

## Using Swift Big Rational in your project

To use Swift Big Rational in a SwiftPM project:

1. Add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/mredig/swift-big-rational.git", .upToNextMinor("1.1.0"))
```

2. Add `BigRationalModule` as a dependency for your target:

```swift
.target(
	name: "TargetName",
	dependencies: [
		.product(name: "BigRationalModule", package: "swift-big-rational")
	]
)
```

3. Add `import BigRationalModule` in your source code.

## API

`BigRationalModule` exports the `Rational` struct. It conforms to standard Swift protocols like `AdditiveArithmetic`, `Numeric`, `Hashable`, `Comparable`, and more.

You can create a `Rational` value using the fraction initializer.
```swift
let half = Rational(2, 4)
print(x.numerator)	// 2
print(x.denominator)	// 4
```

You can also use the integer initializer.
```swift
let one = Rational(1)
```

Or simply an integer literal.
```swift
let two: Rational = 2
```

`Rational` supports the standard arithmetic and comparison operators.
```swift
Rational(1, 2) + Rational(1, 4)		// Rational(3, 4)
Rational(1)    - Rational(1, 2)		// Rational(1, 2)
Rational(2)    * Rational(3, 4)		// Rational(3, 2)
Rational(1)    / Rational(1, 2)		// Rational(2, 1)
Rational(1, 2) < Rational(3, 4)		// true
```

It also provides equivalence when comparing or hashing equal values with different multiples of one:
```swift
Rational(1, 2) == Rational(2, 4)						// true
Rational(1, 2).hashValue == Rational(2, 4).hashValue	// true
```

If you want the reduced value of a fraction, just use the `.reduced` property:
```swift
Rational(2, 4).reduced	// Rational(1, 2)
```
Or pass `true` into the reduced argument when initializing:
```swift
Rational(2, 4, reduced: true)	// Rational(1, 2)
```


## Attributions
A lot of the implementations were ported over to Swift from Python's [fractions](https://github.com/python/cpython/blob/main/Lib/fractions.py) module.
