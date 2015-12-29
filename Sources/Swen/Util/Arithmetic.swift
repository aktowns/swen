//
//   Arithmetic.swift created on 28/12/15
//   Swen project
//
//   Copyright 2015 Ashley Towns <code@ashleytowns.id.au>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

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
