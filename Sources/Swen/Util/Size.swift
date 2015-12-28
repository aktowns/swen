/*
 *   Size.swift
 *   Swen - Toy Swift 2d Engine <root@ashleytowns.id.au>
 *
 *   Methods for dealing with sizes
 */

import Foundation

public struct Size<a: ArithmeticType> : Comparable, CustomStringConvertible {
  /// The with.
  var w: a
  /// The height.
  var h: a

  /// Returns an empty Size
  static func zero() -> Size<a> {
    return Size(w: 0 as! a, h: 0 as! a)
  }

  func toVector() -> Vector<a> {
    return Vector(x: self.w, y: self.h)
  }

  func toPoint() -> Point<a> {
    return Point(x: self.w, y: self.h)
  }

  public var description : String {
    return "\(self.dynamicType)(w:\(w), h:\(h))"
  }
}

public func ==<a>(l: Size<a>, r: Size<a>) -> Bool {
  return (l.w == r.w && l.h == r.h)
}

public func <<a>(l: Size<a>, r: Size<a>) -> Bool {
  return (l.w < r.w && l.h < r.h)
}

public func +<a>(l: Size<a>, r: Size<a>) -> Size<a> {
  return Size(w: l.w + r.w, h: l.h + r.h)
}

public func -<a>(l: Size<a>, r: Size<a>) -> Size<a> {
  return Size(w: l.w - r.w, h: l.h - r.h)
}

public func *<a>(l: Size<a>, r: Size<a>) -> Size<a> {
  return Size(w: l.w * r.w, h: l.h * r.h)
}

public func /<a>(l: Size<a>, r: Size<a>) -> Size<a> {
  return Size(w: l.w / r.w, h: l.h / r.h)
}