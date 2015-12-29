//
//   Point.swift created on 28/12/15
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

public struct Point<a: ArithmeticType> : Comparable, CustomStringConvertible {
  /// The x coordinate of this Point.
  public var x: a
  /// The y coordinate of this Point.
  public var y: a

  public init(x: a, y: a) {
    self.x = x
    self.y = y
  }

  /// Returns a Point with coordinates 0, 0.
  public static func zero() -> Point<a> {
    return Point(x: 0 as! a, y: 0 as! a)
  }

  public func toVector() -> Vector<a> {
    return Vector(x: self.x, y: self.y)
  }

  public var description : String {
    return "\(self.dynamicType)(x:\(x), y:\(y))"
  }
}

public func ==<a>(l: Point<a>, r: Point<a>) -> Bool {
  return (l.x == r.x &&
          l.y == r.y)
}

public func <<a>(l: Point<a>, r: Point<a>) -> Bool {
  return (l.x < r.x &&
          l.y < r.y)
}

public func +<a>(l: Point<a>, r: Point<a>) -> Point<a> {
  return Point(x: l.x + r.x,
               y: l.y + r.y)
}

public func -<a>(l: Point<a>, r: Point<a>) -> Point<a> {
  return Point(x: l.x - r.x,
               y: l.y - r.y)
}

public func *<a>(l: Point<a>, r: Point<a>) -> Point<a> {
  return Point(x: l.x * r.x,
               y: l.y * r.y)
}

public func /<a>(l: Point<a>, r: Point<a>) -> Point<a> {
  return Point(x: l.x / r.x,
               y: l.y / r.y)
}