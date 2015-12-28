/*
 *   Point.swift
 *   Swen - Toy Swift 2d Engine <root@ashleytowns.id.au>
 *
 *   Methods for dealing with points
 */

public struct Point<a: ArithmeticType> : Comparable, CustomStringConvertible {
  /// The x coordinate of this Point.
  var x: a
  /// The y coordinate of this Point.
  var y: a

  /// Returns a Point with coordinates 0, 0.
  static func zero() -> Point<a> {
    return Point(x: 0 as! a, y: 0 as! a)
  }

  func toVector() -> Vector<a> {
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