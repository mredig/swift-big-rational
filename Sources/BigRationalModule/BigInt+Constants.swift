import BigInt
#if canImport(Foundation)
import Foundation
#endif

public extension BigInt {
	static let uInt8Max = BigInt(UInt8.max)
	static let uInt16Max = BigInt(UInt16.max)
	static let uInt32Max = BigInt(UInt32.max)
	static let uInt64Max = BigInt(UInt64.max)
	static let uIntMax = BigInt(UInt.max)

	static let int8Max = BigInt(Int8.max)
	static let int16Max = BigInt(Int16.max)
	static let int32Max = BigInt(Int32.max)
	static let int64Max = BigInt(Int64.max)
	static let intMax = BigInt(Int.max)

	static let int8Min = BigInt(Int8.min)
	static let int16Min = BigInt(Int16.min)
	static let int32Min = BigInt(Int32.min)
	static let int64Min = BigInt(Int64.min)
	static let intMin = BigInt(Int.min)

	@available(macOS 11.0, iOS 14.0, *)
	static let float16Greatest = BigInt(Float16.greatestFiniteMagnitude)
	static let floatGreatest = BigInt(Float.greatestFiniteMagnitude)
	static let doubleGreatest = BigInt(Double.greatestFiniteMagnitude)
	#if canImport(Foundation)
	static let decimalGreatest = BigInt(exactly: Decimal.greatestFiniteMagnitude)!
	#endif
}

public extension BigUInt {
	static let uInt8Max = BigInt.uInt8Max.magnitude
	static let uInt16Max = BigInt.uInt16Max.magnitude
	static let uInt32Max = BigInt.uInt32Max.magnitude
	static let uInt64Max = BigInt.uInt64Max.magnitude
	static let uIntMax = BigInt.uIntMax.magnitude

	static let int8Max = BigInt.int8Max.magnitude
	static let int16Max = BigInt.int16Max.magnitude
	static let int32Max = BigInt.int32Max.magnitude
	static let int64Max = BigInt.int64Max.magnitude
	static let intMax = BigInt.intMax.magnitude

	@available(macOS 11.0, iOS 14.0, *)
	static let float16Greatest = BigInt.float16Greatest.magnitude
	static let floatGreatest = BigInt.floatGreatest.magnitude
	static let doubleGreatest = BigInt.doubleGreatest.magnitude
	#if canImport(Foundation)
	static let decimalGreatest = BigInt.decimalGreatest.magnitude
	#endif
}
