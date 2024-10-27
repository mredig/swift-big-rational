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
		self.init(description, radix: 10, reduced: false)
	}

	public init?(_ description: String, radix: Int = 10, reduced: Bool = false) {
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
			default: break
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

		numeratorAccumulator = numeratorAccumulator.trimmingCharacters(in: .whitespacesAndNewlines)
		denominatorAccumulator = denominatorAccumulator.trimmingCharacters(in: .whitespacesAndNewlines)

		if radix == 16 {
			if numeratorAccumulator.lowercased().hasPrefix("0x") {
				numeratorAccumulator.removeFirst(2)
			}
			if denominatorAccumulator.lowercased().hasPrefix("0x") {
				denominatorAccumulator.removeFirst(2)
			}
		} else if radix == 2 {
			if numeratorAccumulator.lowercased().hasPrefix("0b") {
				numeratorAccumulator.removeFirst(2)
			}
			if denominatorAccumulator.lowercased().hasPrefix("0b") {
				denominatorAccumulator.removeFirst(2)
			}
		}

		guard
			let numerator = BigInt(numeratorAccumulator, radix: radix),
			let denominator = BigInt(denominatorAccumulator, radix: radix)
		else { return nil }
		guard denominator != 0 else {
			self = .nan
			return
		}

		self.init(numerator, denominator, reduced: reduced)
	}
}
