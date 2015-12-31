//
//   Vector.swift created on 28/12/15
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

public struct Vector : Comparable {
  /// The x coordinate of this Vector.
  public var x: Double
  /// The y coordinate of this Vector2.
  public var y: Double

  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }

  public init(x: Int16, y: Int16) {
    self.x = Double(x)
    self.y = Double(y)
  }

  public init(x: Int32, y: Int32) {
    self.x = Double(x)
    self.y = Double(y)
  }

  public static var zero: Vector {
    return Vector(x: 0.0, y: 0.0)
  }
}

public func ==(l: Vector, r: Vector) -> Bool {
  return (l.x == r.x &&
          l.y == r.y)
}
public func <(l: Vector, r: Vector) -> Bool {
  return (l.x < r.x &&
          l.y < r.y)
}

public func +(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x + r.x,
      y: l.y + r.y)
}

public func -(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x - r.x,
      y: l.y - r.y)
}

public func *(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x * r.x,
      y: l.y * r.y)
}

public func /(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x / r.x,
      y: l.y / r.y)
}