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

  /// Negates the vector.
  public var negated: Vector {
    return Vector(x: -self.x, y: -self.y)
  }

  /// Returns a perpendicular vector. (90 degree rotation)
  public var perp: Vector {
    return Vector(x: -self.y, y: self.x)
  }

  /// Returns a perpendicular vector. (-90 degree rotation)
  public var rperp: Vector {
    return Vector(x: self.y, y: -self.x)
  }

  /// Scalar multiplication.
  public func mult(s: Double) -> Vector {
    return Vector(x: self.x * s, y: self.y * s)
  }

  /// Vector dot product.
  public func dot(v2: Vector) -> Double {
    return (self.x * v2.x) + (self.y * v2.y)
  }

  /// 2D vector cross product analog.
  /// The cross product of 2D vectors results in a 3D vector with only a z component.
  /// This function returns the magnitude of the z value.
  public func cross(v2: Vector) -> Double {
    return (self.x * v2.y) - (self.y * v2.x)
  }

  /// Returns the vector projection of the vector onto v2.
  public func project(v2: Vector) -> Vector {
    return v2.mult(self.dot(v2) / v2.dot(v2))
  }

  /// Returns the unit length vector for the given angle (in radians).
  public static func forAngle(a: Double) -> Vector {
    return Vector(x: Math.cos(a), y: Math.sin(a))
  }

  /// Returns the angular direction the vector is pointing in (in radians).
  public var angle: Double {
    return Math.atan2(self.y, self.x)
  }

  /// Uses complex number multiplication to rotate the vector by v2. Scaling will occur
  /// if the vector is not a unit vector.
  public func rotate(v2: Vector) -> Vector {
    return Vector(x: self.x * v2.x - self.y * v2.y, y: self.x * v2.y + self.y * v2.x)
  }

  /// Inverse of rotate().
  public func unrotate(v2: Vector) -> Vector {
    return Vector(x: self.x * v2.x + self.y * v2.y, y: self.y * v2.x - self.x * v2.y)
  }

  /// Returns the squared length of the vector. Faster than length() when you only need to compare lengths.
  public var lengthsq: Double {
    return self.dot(self)
  }

  /// Returns the length of the vector.
  public var length: Double {
    return Math.sqrt(self.dot(self))
  }

  /// Linearly interpolate between the vector and v2.
  public func lerp(v2: Vector, t: Double) -> Vector {
    return self.mult(1.0 - t) + v2.mult(t)
  }

  /// Returns a normalized copy of the vector.
  public var normalize: Vector {
    return self.mult(1.0 / (self.length + Math.DBL_MIN))
  }

  /// Returns the distance between the vector and v2.
  public func dist(v2: Vector) -> Double {
    return (self - v2).length
  }

}

public func ==(l: Vector, r: Vector) -> Bool {
  return (l.x == r.x && l.y == r.y)
}
public func <(l: Vector, r: Vector) -> Bool {
  return (l.x < r.x && l.y < r.y)
}

/// Add two vectors
public func +(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x + r.x, y: l.y + r.y)
}

/// Subtract two vectors.
public func -(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x - r.x, y: l.y - r.y)
}

public func *(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x * r.x, y: l.y * r.y)
}

public func /(l: Vector, r: Vector) -> Vector {
  return Vector(x: l.x / r.x, y: l.y / r.y)
}