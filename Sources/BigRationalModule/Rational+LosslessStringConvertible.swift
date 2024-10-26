import BigInt

extension Rational: LosslessStringConvertible {
	/// Creates a rational value from its string representation.
	///
	/// The string may begin with a + or - character, followed by
	/// one or more digits (0-9), optionally followed by a / character
	/// and one or more digits.
	///
	/// 	Rational("2")      // Rational(2, 1)
	/// 	Rational("2/4")    // Rational(1, 2)
	///     Rational("128/2")    // Rational(128, 2)
	///     Rational("2 / 3")     // Rational(2, 3)
	///     Rational("2_000_000 / 3")     // Rational(2000000, 3)
	///
	/// If the string is in an invalid format, or it describes a value that
	/// cannot be represented within this type, `nil` is returned.
	///
	///     Rational("2/")        // Missing denominator
	///     Rational("1/0")       // Division by zero
	///
	@inlinable
	public init?(_ description: String) {
		self.init(description, reduced: false)
	}

	public init?(_ description: String, reduced: Bool = false) {
		var numeratorAccumulator = ""
		var denominatorAccumulator = ""
		var numeratorFinished = false
		for character in description {
			guard character != "/" else {
				guard numeratorFinished == false else {
					return nil
				}
				numeratorFinished = true
				continue
			}
			switch character {
			case "_":
				continue
			case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", " ":
				break
			default: return nil
			}

			if numeratorFinished {
				denominatorAccumulator.append(character)
			} else {
				numeratorAccumulator.append(character)
			}
		}

		if denominatorAccumulator.isEmpty, numeratorFinished == false {
			denominatorAccumulator = "1"
		}

		guard
			let numerator = BigInt(numeratorAccumulator.trimmingCharacters(in: .whitespacesAndNewlines)),
			let denominator = BigInt(denominatorAccumulator.trimmingCharacters(in: .whitespacesAndNewlines)),
			denominator != 0
		else { return nil }

		self.init(numerator, denominator, reduced: reduced)
	}
}
