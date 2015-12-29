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