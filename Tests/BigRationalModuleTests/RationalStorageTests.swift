import Testing
import BigInt
import BigRationalModule

struct RationalStorageTests {
	@Test func bigUIntIsZero() throws {
		let bigUIntZero = Rational.Storage.bigUInt(BigUInt(0))
		#expect(bigUIntZero.isZero)
	}

	@Test func rationalIsZero() throws {
		let rationalZero = Rational.Storage.rational(Rational(0))
		#expect(rationalZero.isZero)
	}

	@Test func bigUIntIsNotZero() throws {
		let bigUIntNonZero = Rational.Storage.bigUInt(BigUInt(1))
		#expect(!bigUIntNonZero.isZero)
	}

	@Test func bigIntMustBeGreaterThanZero() throws {
		let willBeNull = Rational.Storage.bigInt(BigInt(-1))
		#expect(willBeNull == nil)
	}

	@Test func rationalIsNotZero() throws {
		let rationalNonZero = Rational.Storage.rational(Rational(1))
		#expect(!rationalNonZero.isZero)
	}

	@Test func bigIntIsPositive() throws {
		let bigIntPositive = Rational.Storage.bigUInt(BigUInt(2))
		#expect(bigIntPositive.isPositive)
	}

	@Test func rationalIsPositive() throws {
		let rationalPositive = Rational.Storage.rational(Rational(3, 2))
		#expect(rationalPositive.isPositive)
	}

	@Test func rationalIsNotPositive() throws {
		let rationalNegative = Rational.Storage.rational(Rational(-1, 2))
		#expect(!rationalNegative.isPositive)
	}

	@Test func rationalIsNegative() throws {
		let rationalNegative = Rational.Storage.rational(Rational(-5, 7))
		#expect(rationalNegative.isNegative)
	}

	@Test func bigIntIsNotNegative() throws {
		let bigIntPositive = Rational.Storage.bigUInt(BigUInt(4))
		#expect(!bigIntPositive.isNegative)
	}

	@Test func rationalIsNotNegative() throws {
		let rationalPositive = Rational.Storage.rational(Rational(5, 4))
		#expect(!rationalPositive.isNegative)
	}

	@Test func bigIntIsInteger() throws {
		let bigIntInt = Rational.Storage.bigUInt(BigUInt(5))
		#expect(bigIntInt.isInteger)
	}

	@Test func rationalIsInteger() throws {
		let rationalInt = Rational.Storage.rational(Rational(10, 1))
		#expect(rationalInt.isInteger)
	}

	@Test func rationalIsNotInteger() throws {
		let rationalNonInt = Rational.Storage.rational(Rational(10, 3))
		#expect(!rationalNonInt.isInteger)
	}

	@Test func bigIntEqualsRational() throws {
		let bigIntValue = Rational.Storage.bigUInt(5)
		let rationalValue = Rational.Storage.rational(Rational(5, 1))
		#expect(bigIntValue == rationalValue)
	}

	@Test func rationalEqualsRational() throws {
		let rationalAValue = Rational.Storage.rational(Rational(5, 1))
		let rationalBValue = Rational.Storage.rational(Rational(5, 1))
		#expect(rationalAValue == rationalBValue)
	}

	@Test func bigIntNotEqualsRational() throws {
		let bigIntValue = Rational.Storage.bigUInt(5)
		let rationalValue = Rational.Storage.rational(Rational(5, 2))
		#expect(bigIntValue != rationalValue)
	}

	@Test func bigIntNotEqualToAnotherBigInt() throws {
		let bigIntValue = Rational.Storage.bigUInt(5)
		let differentBigInt = Rational.Storage.bigUInt(6)
		#expect(bigIntValue != differentBigInt)
	}

	@Test func storageBigIntEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.bigUInt(5)
		#expect(storageValue == bigIntValue)
	}

	@Test func storageRationalEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.rational(Rational(5))
		#expect(storageValue == bigIntValue)
	}

	@Test func storageBigIntNotEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.bigUInt(6)
		#expect(storageValue != bigIntValue)
	}

	@Test func storageRationalNotEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.rational(Rational(6))
		#expect(storageValue != bigIntValue)
	}

	@Test func bigIntAndRationalSameHash() throws {
		let bigIntHashValue = Rational.Storage.bigUInt(BigUInt(5)).hashValue
		let rationalHashValue = Rational.Storage.rational(Rational(5, 1)).hashValue

		#expect(bigIntHashValue == rationalHashValue)
	}

	@Test func bigIntAndRationalDifferentHash() throws {
		let bigIntHashValue = Rational.Storage.bigUInt(BigUInt(5)).hashValue
		let rationalHashValue = Rational.Storage.rational(Rational(5, 2)).hashValue

		#expect(bigIntHashValue != rationalHashValue)
	}

	@Test func optionalNilIsNotEqualToInt() throws {
		let opt: Rational.Storage? = nil
		let int = 5

		#expect(opt != 5)
	}

	@Test func compareWrappedBigInts() throws {
		let smaller = Rational.Storage.bigUInt(5)
		let larger = Rational.Storage.bigUInt(6)

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}

	@Test func compareWrappedRationals() throws {
		let smaller = Rational.Storage.rational(Rational(5, 4))
		let larger = Rational.Storage.rational(Rational(6, 3))

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}

	@Test func compareWrappedRationalLargerThanBigInt() throws {
		let smaller = Rational.Storage.bigUInt(1)
		let larger = Rational.Storage.rational(Rational(6, 3))

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}

	@Test func compareWrappedBigIntLargerThanRational() throws {
		let smaller = Rational.Storage.rational(Rational(6, 3))
		let larger = Rational.Storage.bigUInt(10)

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}

	@Test func isIdenticalBigInt() throws {
		let bigInt1 = Rational.Storage.bigUInt(BigUInt(5))
		let bigInt2 = Rational.Storage.bigUInt(BigUInt(5))

		#expect(bigInt1 === bigInt2)
	}

	@Test func isIdenticalBigInt2() throws {
		let bigInt1 = Rational.Storage.bigUInt(BigUInt(5))
		let bigInt2 = Rational.Storage.bigUInt(BigUInt(10) / BigUInt(2))

		#expect(bigInt1 === bigInt2)
	}

	@Test func isNotIdenticalBigUInt() throws {
		let bigInt1 = Rational.Storage.bigUInt(BigUInt(5))
		let bigInt2 = Rational.Storage.bigUInt(BigUInt(6))

		#expect(bigInt1 !== bigInt2)
	}

	@Test func isIdenticalRational() throws {
		let rational1 = Rational.Storage.rational(Rational(5))
		let rational2 = Rational.Storage.rational(Rational(5))

		#expect(rational1 === rational2)
	}

	@Test func isNotIdenticalRational() throws {
		let rational1 = Rational.Storage.rational(Rational(5))
		let rational2 = Rational.Storage.rational(Rational(6))

		#expect(rational1 !== rational2)
	}

	@Test func isNotIdenticalRational2() throws {
		let rational1 = Rational.Storage.rational(Rational(5))
		let rational2 = Rational.Storage.rational(Rational(10, 2))

		#expect(rational1 !== rational2)
	}
}
