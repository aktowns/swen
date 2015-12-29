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