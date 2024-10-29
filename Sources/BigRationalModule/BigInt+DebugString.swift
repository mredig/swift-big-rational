import BigInt

extension BigInt: @retroactive CustomDebugStringConvertible {
	public var debugDescription: String {
		let text = String(self)
		return text + " (\(self.magnitude.bitWidth) bits)"
	}
}

extension BigUInt: @retroactive CustomDebugStringConvertible {
	public var debugDescription: String {
		let text = String(self)
		return text + " (\(self.bitWidth) bits)"
	}
}

