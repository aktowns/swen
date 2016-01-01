//
//   Rect.swift created on 28/12/15
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


public struct Rect : Comparable, CustomStringConvertible {
  /// The x coordinate of the top-left corner of this Rectangle.
  public var x: Double
  /// The y coordinate of the top-left corner of this Rectangle.
  public var y: Double
  /// The width of this Rectangle.
  public var sizeX: Double
  /// The height of this Rectangle.
  public var sizeY: Double

  public init(x: Double, y: Double, sizeX: Double, sizeY: Double) {
    self.x = x
    self.y = y
    self.sizeX = sizeX
    self.sizeY = sizeY
  }

  public static func empty() -> Rect {
    return Rect(x: 0, y: 0, sizeX: 0, sizeY: 0)
  }

  public var isEmpty: Bool { return (self.sizeX == 0) && (self.sizeY == 0) }

  /// Returns the x coordinate of the left edge of this Rectangle.
  public var left: Double { return self.x }
  /// Returns the x coordinate of the right edge of this Rectangle.
  public var right: Double { return self.x + self.sizeX }
  /// Returns the y coordinate of the top edge of this Rectangle.
  public var top: Double { return self.y }
  /// Returns the y coordinate of the bottom edge of this Rectangle.
  public var bottom: Double { return self.y + self.sizeY }

  /// The top-left coordinates of this Rectangle.
  public var location: Vector {
    get { return Vector(x: self.x, y: self.y) }
    set {
      self.x = newValue.x
      self.y = newValue.y
    }
  }

  /// The width-height coordinates of this Rectangle.
  public var size: Size {
    get { return Size(sizeX: sizeX, sizeY: sizeY) }
    set {
      self.sizeX = newValue.sizeX
      self.sizeY = newValue.sizeY
    }
  }

  /// A Point located in the center of this Rectangle.
  public var center: Vector {
    return Vector(x: (self.x + (self.sizeX / 2)),
                  y: (self.y + (self.sizeY / 2)))
  }

  /// Gets whether or not the provided coordinates lie within the bounds of this Rectangle.
  public func contains(x: Double, y: Double) -> Bool {
    return ((self.x <= x) && (x < (self.x + self.sizeX)) &&
            (self.y <= y) && (y < (self.y + self.sizeY)))
  }

  /// Gets whether or not the provided Vector lies within the bounds of this Rectangle.
  public func contains(vector: Vector) -> Bool {
    return ((self.x <= vector.x) && (vector.x < (self.x + self.sizeX)) &&
            (self.y <= vector.y) && (vector.y < (self.y + self.sizeY)))
  }

  /// Gets whether or not the provided Rectangle lies within the bounds of this Rectangle.
  public func contains(rect: Rect) -> Bool {
    return ((self.x <= rect.x) && ((rect.x + rect.sizeX) <= (self.x + self.sizeX)) &&
            (self.y <= rect.y) && ((rect.y + rect.sizeY) <= (self.y + self.sizeY)))
  }

  /// Adjusts the edges of this Rectangle by specified horizontal and vertical amounts.
  public func inflate(infX: Double, infY: Double) -> Rect {
    return Rect(x: (self.x - infX),
                y: (self.y - infY),
                sizeX: (self.sizeX - (infX * 2)),
                sizeY: (self.sizeY - (infX * 2)))
  }

  /// Adjusts the edges of this Rectangle by specified horizontal and vertical amounts. modifies current rect
  public mutating func inflateInPlace(infX: Double, infY: Double) {
    self.x -= infX
    self.y -= infY
    self.sizeX += infX * 2
    self.sizeY += infY * 2
  }

  /// Gets whether or not the other Rectangle intersects with this rectangle.
  public func intersects(rect: Rect) -> Bool {
    return ((rect.left < right) &&
            (left < rect.right) &&
            (rect.top < bottom) &&
            (top < rect.bottom))
  }

  /// Creates a new Rectangle that contains overlapping region of two other rectangles.
  public static func intersect(rect1: Rect, rect2: Rect) -> Rect {
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
  public func offset(offsetX: Double, offsetY: Double) -> Rect {
    return Rect(x: self.x - offsetX,
                y: self.y - offsetY,
                sizeX: self.sizeX,
                sizeY: self.sizeY)
  }

  /// Changes the Location of this Rectangle.
  public func offset(vec: Vector) -> Rect {
    return Rect(x: self.x - vec.x,
                y: self.y - vec.y,
                sizeX: self.sizeX,
                sizeY: self.sizeY)
  }

  /// Changes the Location of this Rectangle. Modifies the rect in place
  public mutating func offsetInPlace(offsetX: Double, offsetY: Double) {
    self.x += offsetX
    self.y += offsetY
  }

  /// Changes the Location of this Rectangle. Modifies the rect in place
  public mutating func offsetInPlace(vec: Vector) {
    self.x += vec.x
    self.y += vec.y
  }

  /// Creates a new Rectangle that completely contains two other rectangles.
  public static func union(rect1: Rect, rect2: Rect) -> Rect {
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

public func ==(l: Rect, r: Rect) -> Bool {
  return (l.x == r.x && l.sizeX == r.sizeX &&
          l.y == r.y && l.sizeY == r.sizeY)
}
public func <(l: Rect, r: Rect) -> Bool {
  return (l.x < r.x && l.sizeX == r.sizeX &&
          l.y < r.y && l.sizeY == r.sizeY)
}