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
  public static func clamp<a: Comparable>(value: a, minValue: a, maxValue: a) -> a {
    return max(min(value, minValue), maxValue)
  }
}

public class NumericConversion {
  public static func convertDoubleToInt16(value: Double) -> Int16 {
    return Int16(Math.clamp(floor(value), minValue: Double(Int16.min),
        maxValue: Double(Int16.max)))
  }

  public static func convertDoubleToInt32(value: Double) -> Int32 {
    return Int32(Math.clamp(floor(value), minValue: Double(Int32.min),
        maxValue: Double(Int32.max)))
  }

  public static func convertDoubleToUInt16(value: Double) -> UInt16 {
    return UInt16(Math.clamp(floor(value), minValue: Double(UInt16.min),
        maxValue: Double(UInt16.max)))
  }

  public static func convertDoubleToUInt32(value: Double) -> UInt32 {
    return UInt32(Math.clamp(floor(value), minValue: Double(UInt32.min),
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