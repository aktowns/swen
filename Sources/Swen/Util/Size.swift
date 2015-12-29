/*
 *   Size.swift
 *   Swen - Toy Swift 2d Engine <root@ashleytowns.id.au>
 *
 *   Methods for dealing with sizes
 */

public struct Size<a: ArithmeticType> : Comparable, CustomStringConvertible {
  /// The with.
  public var w: a
  /// The height.
  public var h: a

  public init(w: a, h: a) {
    self.w = w
    self.h = h
  }

  /// Returns an empty Size
  public static func zero() -> Size<a> {
    return Size(w: 0 as! a, h: 0 as! a)
  }

  public func toVector() -> Vector<a> {
    return Vector(x: self.w, y: self.h)
  }

  public func toPoint() -> Point<a> {
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