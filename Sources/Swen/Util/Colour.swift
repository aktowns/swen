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
  public var r: UInt8
  public var g: UInt8
  public var b: UInt8
  public var a: UInt8?

  public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  }

  public init(r: UInt8, g: UInt8, b: UInt8) {
    self.r = r
    self.g = g
    self.b = b
    self.a = nil
  }

  public static var black: Colour {
    return Colour(r: 0x00, g: 0x00, b: 0x00, a: 0x00)
  }

  public static var white: Colour {
    return Colour(r: 0xFF, g: 0xFF, b: 0xFF, a: 0x00)
  }
}