//
//   Size.swift created on 28/12/15
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


public struct Size : Comparable, CustomStringConvertible {
  /// The with.
  public var sizeX: Double
  /// The height.
  public var sizeY: Double

  public init(sizeX: Double, sizeY: Double) {
    self.sizeX = sizeX
    self.sizeY = sizeY
  }

  public init(sizeX: Int32, sizeY: Int32) {
    self.sizeX = Double(sizeX)
    self.sizeY = Double(sizeY)
  }

  public init(sizeX: Int16, sizeY: Int16) {
    self.sizeX = Double(sizeX)
    self.sizeY = Double(sizeY)
  }

  /// Returns an empty Size
  public static var zero: Size {
    return Size(sizeX: 0.0, sizeY: 0.0)
  }

  public func toVector() -> Vector {
    return Vector(x: self.sizeX, y: self.sizeY)
  }

  public var center: Vector {
    return Vector(x: self.sizeX / 2, y: self.sizeY / 2)
  }

  public var description : String {
    return "\(self.dynamicType)(sizeX:\(sizeX), sizeY:\(sizeY))"
  }
}

public func ==(l: Size, r: Size) -> Bool {
  return (l.sizeX == r.sizeX && l.sizeY == r.sizeY)
}

public func <(l: Size, r: Size) -> Bool {
  return (l.sizeX < r.sizeX && l.sizeY < r.sizeY)
}

public func +(l: Size, r: Size) -> Size {
  return Size(sizeX: l.sizeX + r.sizeX, sizeY: l.sizeY + r.sizeY)
}

public func -(l: Size, r: Size) -> Size {
  return Size(sizeX: l.sizeX - r.sizeX, sizeY: l.sizeY - r.sizeY)
}

public func *(l: Size, r: Size) -> Size {
  return Size(sizeX: l.sizeX * r.sizeX, sizeY: l.sizeY * r.sizeY)
}

public func /(l: Size, r: Size) -> Size {
  return Size(sizeX: l.sizeX / r.sizeX, sizeY: l.sizeY / r.sizeY)
}