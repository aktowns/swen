/*
 *   Rect.swift
 *   Swen - Toy Swift 2d Engine <root@ashleytowns.id.au>
 *
 *   Methods for dealing with rects
 */

import Foundation

public struct Rect<a: ArithmeticType> : Comparable {
  /// The x coordinate of the top-left corner of this Rectangle.
  var x: a
  /// The y coordinate of the top-left corner of this Rectangle.
  var y: a
  /// The width of this Rectangle.
  var sizeX: a
  /// The height of this Rectangle.
  var sizeY: a

  static func empty() -> Rect<a> {
    return Rect(x: 0 as! a, y: 0 as! a, sizeX: 0 as! a, sizeY: 0 as! a)
  }

  var isEmpty: Bool { return (self.sizeX == (0 as! a)) && (self.sizeY == (0 as! a)) }

  /// Returns the x coordinate of the left edge of this Rectangle.
  var left: a { return self.x }
  /// Returns the x coordinate of the right edge of this Rectangle.
  var right: a { return self.x + self.sizeX }
  /// Returns the y coordinate of the top edge of this Rectangle.
  var top: a { return self.y }
  /// Returns the y coordinate of the bottom edge of this Rectangle.
  var bottom: a { return self.y + self.sizeY }

  /// The top-left coordinates of this Rectangle.
  var location: Point<a> {
    get { return Point(x: self.x, y: self.y) }
    set {
      self.x = newValue.x
      self.y = newValue.y
    }
  }

  /// The width-height coordinates of this Rectangle.
  var size: Point<a> {
    get { return Point(x: sizeX, y: sizeY) }
    set {
      self.sizeX = newValue.x
      self.sizeY = newValue.y
    }
  }

  /// A Point located in the center of this Rectangle.
  var center: Point<a> {
    return Point(x: (self.x + (self.sizeX / (2 as! a))),
                 y: (self.y + (self.sizeY / (2 as! a))))
  }

  /// Gets whether or not the provided coordinates lie within the bounds of this Rectangle.
  public func contains(x: a, y: a) -> Bool {
    return ((self.x <= x) && (x < (self.x + self.sizeX)) &&
            (self.y <= y) && (y < (self.y + self.sizeY)))
  }

  /// Gets whether or not the provided Point lies within the bounds of this Rectangle.
  public func contains(point: Point<a>) -> Bool {
    return ((self.x <= point.x) && (point.x < (self.x + self.sizeX)) &&
            (self.y <= point.y) && (point.y < (self.y + self.sizeY)))
  }

  /// Gets whether or not the provided Vector lies within the bounds of this Rectangle.
  public func contains(vector: Vector<a>) -> Bool {
    return ((self.x <= vector.x) && (vector.x < (self.x + self.sizeX)) &&
            (self.y <= vector.y) && (vector.y < (self.y + self.sizeY)))
  }

  /// Gets whether or not the provided Rectangle lies within the bounds of this Rectangle.
  public func contains(rect: Rect<a>) -> Bool {
    return ((self.x <= rect.x) && ((rect.x + rect.sizeX) <= (self.x + self.sizeX)) &&
            (self.y <= rect.y) && ((rect.y + rect.sizeY) <= (self.y + self.sizeY)))
  }

  /// Adjusts the edges of this Rectangle by specified horizontal and vertical amounts.
  public func inflate(infX: a, infY: a) -> Rect<a> {
    return Rect(x: (self.x - infX),
                y: (self.y - infY),
                sizeX: (self.sizeX - (infX * (2 as! a))),
                sizeY: (self.sizeY - (infX * (2 as! a))))
  }

  /// Adjusts the edges of this Rectangle by specified horizontal and vertical amounts. modifies current rect
  public mutating func inflateInPlace(infX: a, infY: a) {
    self.x -= infX
    self.y -= infY
    self.sizeX += infX * (2 as! a)
    self.sizeY += infY * (2 as! a)
  }

  /// Gets whether or not the other Rectangle intersects with this rectangle.
  public func intersects(rect: Rect<a>) -> Bool {
    return ((rect.left < right) &&
            (left < rect.right) &&
            (rect.top < bottom) &&
            (top < rect.bottom))
  }

  /// Creates a new Rectangle that contains overlapping region of two other rectangles.
  public static func intersect(rect1: Rect<a>, rect2: Rect<a>) -> Rect<a> {
    if rect1.intersects(rect2) {
      let rightSide = min(rect1.right, rect2.right)
      let leftSide = max(rect1.x, rect2.x)
      let topSide = max(rect1.y, rect2.y)
      let bottomSide = min(rect1.bottom, rect2.bottom)

      return Rect(x: leftSide, y: topSide, sizeX: rightSide - leftSide, sizeY: bottomSide - topSide)
    } else {
      return Rect.empty()
    }
  }

  /// Changes the Location of this Rectangle.
  public func offset(offsetX: a, offsetY: a) -> Rect<a> {
    return Rect(x: self.x - offsetX,
                y: self.y - offsetY,
                sizeX: self.sizeX,
                sizeY: self.sizeY)
  }

  /// Changes the Location of this Rectangle.
  public func offset(point: Point<a>) -> Rect<a> {
    return Rect(x: self.x - point.x,
                y: self.y - point.y,
                sizeX: self.sizeX,
                sizeY: self.sizeY)
  }

  /// Changes the Location of this Rectangle.
  public func offset(vec: Vector<a>) -> Rect<a> {
    return Rect(x: self.x - vec.x,
                y: self.y - vec.y,
                sizeX: self.sizeX,
                sizeY: self.sizeY)
  }

  /// Changes the Location of this Rectangle. Modifies the rect in place
  public mutating func offsetInPlace(offsetX: a, offsetY: a) {
    self.x += offsetX
    self.y += offsetY
  }

  /// Changes the Location of this Rectangle. Modifies the rect in place
  public mutating func offsetInPlace(point: Point<a>) {
    self.x += point.x
    self.y += point.y
  }

  /// Changes the Location of this Rectangle. Modifies the rect in place
  public mutating func offsetInPlace(vec: Vector<a>) {
    self.x += vec.x
    self.y += vec.y
  }

  /// Creates a new Rectangle that completely contains two other rectangles.
  public static func union(rect1: Rect<a>, rect2: Rect<a>) -> Rect<a> {
    let x = min(rect1.x, rect2.x)
    let y = min(rect1.y, rect2.y)
    let sizeX = max(rect1.right, rect2.right) - x
    let sizeY = max(rect1.bottom, rect2.bottom) - y

    return Rect(x: x, y: y, sizeX: sizeX, sizeY: sizeY)
  }

  public var description : String {
    return "#\(self.dynamicType)(x:\(x), y:\(y), sizeX:\(sizeX), sizeY:\(sizeY))"
  }
}

public func ==<a>(l: Rect<a>, r: Rect<a>) -> Bool {
  return (l.x == r.x && l.sizeX == r.sizeX &&
          l.y == r.y && l.sizeY == r.sizeY)
}
public func <<a>(l: Rect<a>, r: Rect<a>) -> Bool {
  return (l.x < r.x && l.sizeX == r.sizeX &&
          l.y < r.y && l.sizeY == r.sizeY)
}