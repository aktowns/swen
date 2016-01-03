//
//   PhyDebugSDL.swift created on 2/01/16
//   Swen project
//
//   Copyright 2016 Ashley Towns <code@ashleytowns.id.au>
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

public class PhyDebugSDL: PhyDebugDrawDelegate {
  let renderer: Renderer

  public init(withRenderer: Renderer) {
    self.renderer = withRenderer
  }

  public func drawSegment(a a: Vector, b: Vector, color: Colour) {
    renderer.drawColour = color
    renderer.draw(startingFrom: a, endingAt: b)
  }

  public func drawDot(size size: Double, pos: Vector, color: Colour) {
    renderer.fillCircle(position: pos, rad: size.int16, colour: color)
  }

  public func drawCircle(pos pos: Vector,
                         angle: Double,
                         radius: Double,
                         outlineColor: Colour,
                         fillColor: Colour) {
    renderer.fillCircle(position: pos, rad: radius.int16, colour: fillColor)
    renderer.drawCircle(position: pos, rad: radius.int16, colour: outlineColor)
  }

  public func drawColour(shape shape: PhyShape) -> Colour {
    guard let tag = shape.tag else {
      return Colour.red.alpha(100)
    }

    switch tag {
      case "wall": return Colour.black.alpha(5)
      case "box": return Colour.yellow.alpha(100)
      case "ball": return Colour.red.alpha(100)
      case "player": return Colour.orange.alpha(100)
      default: return Colour.red.alpha(100)
    }

  }

  public func drawFatSegment(a a: Vector,
                             b: Vector,
                             radius: Double,
                             outlineColor: Colour,
                             fillColor: Colour) {

    let n = (b - a).rperp.normalize
    let t = n.rperp

    var r = radius + 1.0
    if r <= 1.0 {
      r = 1.0
    }

    let nw = n.mult(r)
    let tw = t.mult(r)

    let v0 = b - (nw + tw)
    let v1 = b + (nw - tw)
    let v2 = b - nw
    let v3 = b + nw
    let v4 = a - nw
    let v5 = a + nw
    let v6 = a - (nw - tw)
    let v7 = a + (nw + tw)

    renderer.fillTrigon(point1: v0, point2: v1, point3: v2, colour: fillColor)
    renderer.fillTrigon(point1: v3, point2: v1, point3: v2, colour: fillColor)
    renderer.fillTrigon(point1: v3, point2: v4, point3: v2, colour: fillColor)
    renderer.fillTrigon(point1: v3, point2: v4, point3: v5, colour: fillColor)
    renderer.fillTrigon(point1: v6, point2: v4, point3: v5, colour: fillColor)
    renderer.fillTrigon(point1: v6, point2: v7, point3: v5, colour: fillColor)

    renderer.drawTrigon(point1: v0, point2: v1, point3: v2, colour: outlineColor)
    renderer.drawTrigon(point1: v3, point2: v1, point3: v2, colour: outlineColor)
    renderer.drawTrigon(point1: v3, point2: v4, point3: v2, colour: outlineColor)
    renderer.drawTrigon(point1: v3, point2: v4, point3: v5, colour: outlineColor)
    renderer.drawTrigon(point1: v6, point2: v4, point3: v5, colour: outlineColor)
    renderer.drawTrigon(point1: v6, point2: v7, point3: v5, colour: outlineColor)
  }

  public func drawPolygon(count count: Int32,
                          verts: Array<Vector>,
                          radius: Double,
                          outlineColor: Colour,
                          fillColor: Colour) {
    renderer.fillPolygon(verts: verts, colour: fillColor)
    renderer.drawPolygon(verts: verts, colour: outlineColor)
  }
}
