//
//   Math.swift created on 31/12/15
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

import Glibc

public class Math {
  public static let DBL_MIN = 2.22507385850720138309e-308
  public static let DBL_MAX = 1.79769313486231570815e+308

  public static func clamp<Num:Comparable>(value: Num, minValue: Num, maxValue: Num) -> Num {
    return max(min(value, maxValue), minValue)
  }

  public static func sqrt(x: Double) -> Double {
    return Glibc.sqrt(x)
  }

  public static func sin(x: Double) -> Double {
    return Glibc.sin(x)
  }

  public static func cos(x: Double) -> Double {
    return Glibc.cos(x)
  }

  public static func acos(x: Double) -> Double {
    return Glibc.acos(x)
  }

  public static func atan(x: Double) -> Double {
    return Glibc.atan(x)
  }

  public static func atan2(x: Double, _ y: Double) -> Double {
    return Glibc.atan2(x, y)
  }

  public static func fmod(x: Double, _ y: Double) -> Double {
    return Glibc.fmod(x, y)
  }

  public static func exp(x: Double) -> Double {
    return Glibc.exp(x)
  }

  public static func pow(x: Double, _ y: Double) -> Double {
    return Glibc.pow(x, y)
  }

  public static func floor(x: Double) -> Double {
    return Glibc.floor(x)
  }

  public static func ceil(x: Double) -> Double {
    return Glibc.ceil(x)
  }

  /// Linearly interpolate from @c f1 to @c f2 by no more than @c d.
  public static func lerp(f1: Double, _ f2: Double, _ d: Double) -> Double {
    return f1 + Math.clamp(f2 - f1, minValue: -d, maxValue: d)
  }
}

public class NumericConversion {
  public static func convertDoubleToInt16(value: Double) -> Int16 {
    return Int16(Math.clamp(Math.floor(value), minValue: Double(Int16.min),
        maxValue: Double(Int16.max)))
  }

  public static func convertDoubleToInt32(value: Double) -> Int32 {
    return Int32(Math.clamp(Math.floor(value), minValue: Double(Int32.min),
        maxValue: Double(Int32.max)))
  }

  public static func convertDoubleToUInt16(value: Double) -> UInt16 {
    return UInt16(Math.clamp(Math.floor(value), minValue: Double(UInt16.min),
        maxValue: Double(UInt16.max)))
  }

  public static func convertDoubleToUInt32(value: Double) -> UInt32 {
    return UInt32(Math.clamp(Math.floor(value), minValue: Double(UInt32.min),
        maxValue: Double(UInt32.max)))
  }
}

extension Double {
  public var int16: Int16 {
    return NumericConversion.convertDoubleToInt16(self)
  }
  public var uint16: UInt16 {
    return NumericConversion.convertDoubleToUInt16(self)
  }
  public var int32: Int32 {
    return NumericConversion.convertDoubleToInt32(self)
  }
  public var uint32: UInt32 {
    return NumericConversion.convertDoubleToUInt32(self)
  }
}
