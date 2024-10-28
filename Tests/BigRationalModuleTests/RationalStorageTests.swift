import Testing
import BigInt
import BigRationalModule

struct RationalStorageTests {
	@Test func bigIntIsZero() throws {
		let bigIntZero = Rational.Storage.bigInt(BigInt(0))
		#expect(bigIntZero.isZero)
	}

	@Test func rationalIsZero() throws {
		let rationalZero = Rational.Storage.rational(Rational(0))
		#expect(rationalZero.isZero)
	}

	@Test func bigIntIsNotZero() throws {
		let bigIntNonZero = Rational.Storage.bigInt(BigInt(1))
		#expect(!bigIntNonZero.isZero)
	}

	@Test func rationalIsNotZero() throws {
		let rationalNonZero = Rational.Storage.rational(Rational(1))
		#expect(!rationalNonZero.isZero)
	}

	@Test func bigIntIsPositive() throws {
		let bigIntPositive = Rational.Storage.bigInt(BigInt(2))
		#expect(bigIntPositive.isPositive)
	}

	@Test func rationalIsPositive() throws {
		let rationalPositive = Rational.Storage.rational(Rational(3, 2))
		#expect(rationalPositive.isPositive)
	}

	@Test func bigIntIsNotPositive() throws {
		let bigIntNegative = Rational.Storage.bigInt(BigInt(-1))
		#expect(!bigIntNegative.isPositive)
	}

	@Test func rationalIsNotPositive() throws {
		let rationalNegative = Rational.Storage.rational(Rational(-1, 2))
		#expect(!rationalNegative.isPositive)
	}

	@Test func bigIntIsNegative() throws {
		let bigIntNegative = Rational.Storage.bigInt(BigInt(-3))
		#expect(bigIntNegative.isNegative)
	}

	@Test func rationalIsNegative() throws {
		let rationalNegative = Rational.Storage.rational(Rational(-5, 7))
		#expect(rationalNegative.isNegative)
	}

	@Test func bigIntIsNotNegative() throws {
		let bigIntPositive = Rational.Storage.bigInt(BigInt(4))
		#expect(!bigIntPositive.isNegative)
	}

	@Test func rationalIsNotNegative() throws {
		let rationalPositive = Rational.Storage.rational(Rational(5, 4))
		#expect(!rationalPositive.isNegative)
	}

	@Test func bigIntIsInteger() throws {
		let bigIntInt = Rational.Storage.bigInt(BigInt(5))
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
		let bigIntValue = Rational.Storage.bigInt(5)
		let rationalValue = Rational.Storage.rational(Rational(5, 1))
		#expect(bigIntValue == rationalValue)
	}

	@Test func rationalEqualsRational() throws {
		let rationalAValue = Rational.Storage.rational(Rational(5, 1))
		let rationalBValue = Rational.Storage.rational(Rational(5, 1))
		#expect(rationalAValue == rationalBValue)
	}

	@Test func bigIntNotEqualsRational() throws {
		let bigIntValue = Rational.Storage.bigInt(5)
		let rationalValue = Rational.Storage.rational(Rational(5, 2))
		#expect(bigIntValue != rationalValue)
	}

	@Test func bigIntNotEqualToAnotherBigInt() throws {
		let bigIntValue = Rational.Storage.bigInt(5)
		let differentBigInt = Rational.Storage.bigInt(6)
		#expect(bigIntValue != differentBigInt)
	}

	@Test func storageBigIntEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.bigInt(5)
		#expect(storageValue == bigIntValue)
	}

	@Test func storageRationalEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.rational(Rational(5))
		#expect(storageValue == bigIntValue)
	}

	@Test func storageBigIntNotEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.bigInt(6)
		#expect(storageValue != bigIntValue)
	}

	@Test func storageRationalNotEqualToBigInt() throws {
		let bigIntValue: BigInt = 5
		let storageValue = Rational.Storage.rational(Rational(6))
		#expect(storageValue != bigIntValue)
	}

	@Test func bigIntAndRationalSameHash() throws {
		let bigIntHashValue = Rational.Storage.bigInt(BigInt(5)).hashValue
		let rationalHashValue = Rational.Storage.rational(Rational(5, 1)).hashValue

		#expect(bigIntHashValue == rationalHashValue)
	}

	@Test func bigIntAndRationalDifferentHash() throws {
		let bigIntHashValue = Rational.Storage.bigInt(BigInt(5)).hashValue
		let rationalHashValue = Rational.Storage.rational(Rational(5, 2)).hashValue

		#expect(bigIntHashValue != rationalHashValue)
	}

	@Test func compareWrappedBigInts() throws {
		let smaller = Rational.Storage.bigInt(5)
		let larger = Rational.Storage.bigInt(6)

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
		let smaller = Rational.Storage.bigInt(1)
		let larger = Rational.Storage.rational(Rational(6, 3))

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}

	@Test func compareWrappedBigIntLargerThanRational() throws {
		let smaller = Rational.Storage.rational(Rational(6, 3))
		let larger = Rational.Storage.bigInt(10)

		#expect(smaller < larger)
		#expect(larger > smaller)
		#expect(smaller <= larger)
		#expect(larger >= smaller)
	}
}
