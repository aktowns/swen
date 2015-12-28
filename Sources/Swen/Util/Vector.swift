/*
 *   Vector.swift
 *   Swen - Toy Swift 2d Engine <root@ashleytowns.id.au>
 *
 *   Methods for dealing with 2d vectors
 */

public struct Vector<a: ArithmeticType> : Comparable {
  /// The x coordinate of this Vector.
  var x: a
  /// The y coordinate of this Vector2.
  var y: a

  static var zero: Vector<a> {
    return Vector(x: 0 as! a, y: 0 as! a)
  }
}

public func ==<a>(l: Vector<a>, r: Vector<a>) -> Bool {
  return (l.x == r.x &&
          l.y == r.y)
}
public func <<a>(l: Vector<a>, r: Vector<a>) -> Bool {
  return (l.x < r.x &&
          l.y < r.y)
}