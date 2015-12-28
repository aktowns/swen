import Foundation

// Smaller cut of IntegerArithmeticType for floating point numbers aswell
public protocol ArithmeticType : Comparable {
  /// Add `lhs` and `rhs`, returning a result
  func +(lhs: Self, rhs: Self) -> Self
  /// Subtract `lhs` and `rhs`, returning a result
  func -(lhs: Self, rhs: Self) -> Self
  /// Multiply `lhs` and `rhs`, returning a result
  func *(lhs: Self, rhs: Self) -> Self
  /// Divide `lhs` and `rhs`, returning a result
  func /(lhs: Self, rhs: Self) -> Self
  /// Divide `lhs` and `rhs`, returning the remainder
  func %(lhs: Self, rhs: Self) -> Self

  /// add `lhs` and `rhs` and store the result in `lhs`
  func +=(inout lhs: Self, rhs: Self)
  /// subtract `lhs` and `rhs` and store the result in `lhs`
  func -=(inout lhs: Self, rhs: Self)
}

extension Bit : ArithmeticType {}
extension Int : ArithmeticType {}
extension Int8 : ArithmeticType {}
extension Int16 : ArithmeticType {}
extension Int32 : ArithmeticType {}
extension Int64 : ArithmeticType {}
extension UInt : ArithmeticType {}
extension UInt8 : ArithmeticType {}
extension UInt16 : ArithmeticType {}
extension UInt32 : ArithmeticType {}
extension UInt64 : ArithmeticType {}
extension Float : ArithmeticType {}
extension Double : ArithmeticType {}
