

import CoreGraphics

public extension Int {
  /**
   * Ensures that the integer value stays with the specified range.
   */
  public func clamped(range: Range<Int>) -> Int {
    return (self < range.startIndex) ? range.startIndex : ((self >= range.endIndex) ? range.endIndex - 1: self)
  }

  /**
   * Ensures that the integer value stays with the specified range.
   */
  public mutating func clamp(range: Range<Int>) -> Int {
    self = clamped(range)
    return self
  }

  /**
   * Ensures that the integer value stays between the given values, inclusive.
   */
  public func clamped(v1: Int, _ v2: Int) -> Int {
    let min = v1 < v2 ? v1 : v2
    let max = v1 > v2 ? v1 : v2
    return self < min ? min : (self > max ? max : self)
  }

  /**
   * Ensures that the integer value stays between the given values, inclusive.
   */
  public mutating func clamp(v1: Int, _ v2: Int) -> Int {
    self = clamped(v1, v2)
    return self
  }

  /**
   * Returns a random integer in the specified range.
   */
  public static func random(range: Range<Int>) -> Int {
    return Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
  }

  /**
   * Returns a random integer between 0 and n-1.
   */
  public static func random(n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }

  /**
   * Returns a random integer in the range min...max, inclusive.
   */
  public static func random(min min: Int, max: Int) -> Int {
    assert(min < max)
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
  }
}
