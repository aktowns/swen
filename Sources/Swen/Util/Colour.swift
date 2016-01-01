//
//   Colour.swift created on 28/12/15
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

public struct Colour {
  static let DEFAULT_ALPHA: UInt8 = 120

  public var r: UInt8
  public var g: UInt8
  public var b: UInt8
  public var a: UInt8

  public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  }

  public init(r: UInt8, g: UInt8, b: UInt8) {
    self.init(r: r, g: g, b: b, a: Colour.DEFAULT_ALPHA)
  }

  public init(hex: UInt32) {
    self.init(r: UInt8(hex >> 24 & 255),
              g: UInt8(hex >> 16 & 255),
              b: UInt8(hex >> 8 & 255),
              a: UInt8(hex & 255))
  }

  public init(rgba: (UInt8, UInt8, UInt8, UInt8)) {
    self.init(r: rgba.0, g: rgba.1, b: rgba.2, a: rgba.3)
  }

  public init(rgb: (UInt8, UInt8, UInt8)) {
    self.init(r: rgb.0, g: rgb.1, b: rgb.2, a: Colour.DEFAULT_ALPHA)
  }

  public func alpha(a: UInt8) -> Colour {
    return Colour(rgba: (self.r, self.g, self.b, a))
  }

  public var hex: UInt32 {
    return (UInt32(self.r) << 24 | UInt32(self.g) << 16 | UInt32(self.b) << 8 | UInt32(self.a))
  }

  public static var black: Colour {
    return Colour(hex: 0x000000FF)
  }

  public static var white: Colour {
    return Colour(hex: 0xFFFFFFFF)
  }

  public static var red: Colour {
    return Colour(hex: 0xFF0000FF)
  }

  public static var green: Colour {
    return Colour(hex: 0x00FF00FF)
  }

  public static var blue: Colour {
    return Colour(hex: 0x0000FFFF)
  }

  public static var lightRed: Colour {
    return Colour(hex: 0xff9999FF)
  }

  public static var lightGreen: Colour {
    return Colour(hex: 0xccffccFF)
  }

  public static var lightBlue: Colour {
    return Colour(hex: 0x66ccffFF)
  }

  public static var yellow: Colour {
    return Colour(hex: 0xFFFF00FF)
  }

  public static var orange: Colour {
    return Colour(hex: 0xff9900FF)
  }

  public static var purple: Colour {
    return Colour(hex: 0x660066FF)
  }
}