import BigInt

extension BigInt: @retroactive CustomDebugStringConvertible {
	public var debugDescription: String {
		(playgroundDescription as? String) ?? description
	}
}

extension BigUInt: @retroactive CustomDebugStringConvertible {
	public var debugDescription: String {
		(playgroundDescription as? String) ?? description
	}
}

