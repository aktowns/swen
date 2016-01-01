//
//   Renderer.swift created on 27/12/15
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

import CSDL

public struct RenderFlip : OptionSetType {
  public let rawValue: UInt32

  public init(rawValue: UInt32) {
    self.rawValue = rawValue
  }

  static let None       = RenderFlip(rawValue: SDL_FLIP_NONE.rawValue)
  static let Horizontal = RenderFlip(rawValue: SDL_FLIP_HORIZONTAL.rawValue)
  static let Vertical   = RenderFlip(rawValue: SDL_FLIP_VERTICAL.rawValue)

  var asSDL: SDL_RendererFlip {
    return SDL_RendererFlip(self.rawValue)
  }
}

public struct RenderFlags : OptionSetType {
  public let rawValue: UInt32

  public init(rawValue: UInt32) {
    self.rawValue = rawValue
  }

  static let Software      = RenderFlags(rawValue: SDL_RENDERER_SOFTWARE.rawValue)
  static let Accelerated   = RenderFlags(rawValue: SDL_RENDERER_ACCELERATED.rawValue)
  static let PresentVSync  = RenderFlags(rawValue: SDL_RENDERER_PRESENTVSYNC.rawValue)
  static let TargetTexture = RenderFlags(rawValue: SDL_RENDERER_TARGETTEXTURE.rawValue)
}

public class Renderer {
  public typealias RawRenderer = COpaquePointer

  let handle: RawRenderer

  public init(fromHandle handle: RawRenderer) {
    assert(handle != nil, "Renderer.init(fromHandle:) given a null handle")

    self.handle = handle
  }

  public convenience init(forWindowHandle window: Window.RawWindow, index: Int32, andFlags flags: RenderFlags) throws {
    let ptr = SDL_CreateRenderer(window, index, flags.rawValue)

    if ptr == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    self.init(fromHandle: ptr)
  }

  public convenience init(forWindow window: Window, index: Int32, andFlags flags: RenderFlags) throws {
    try self.init(forWindowHandle: window.handle, index: index, andFlags: flags)
  }

  public convenience init(forWindowHandle window: Window.RawWindow) throws {
    try self.init(forWindowHandle: window, index: -1, andFlags: [RenderFlags.Accelerated, RenderFlags.PresentVSync])
  }

  public convenience init(forWindow window: Window) throws {
    try self.init(forWindowHandle: window.handle)
  }

  public convenience init(forSurface surface: Surface) {
    let ptr = SDL_CreateSoftwareRenderer(surface.handle)

    self.init(fromHandle: ptr)
  }

  deinit {
    SDL_DestroyRenderer(self.handle)
  }

  public func clear() {
    let res = SDL_RenderClear(self.handle)
    assert(res == 0, "SDL_RenderClear failed")
  }

  public func copy(texture texture: Texture) {
    let res = SDL_RenderCopy(self.handle, texture.handle, nil, nil)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture,
                   sourceRect srcrect: Rect) {
    var srcSDLRect = SDL_Rect.fromRect(srcrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, &srcSDLRect, nil)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture, destinationRect dstrect: Rect) {
    var dstSDLRect = SDL_Rect.fromRect(dstrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, nil, &dstSDLRect)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture,
                   sourceRect srcrect: Rect,
                   destinationRect dstrect: Rect) {
    var srcSDLRect: SDL_Rect = SDL_Rect.fromRect(srcrect)
    var dstSDLRect: SDL_Rect = SDL_Rect.fromRect(dstrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, &srcSDLRect, &dstSDLRect)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture,
                   sourceRect srcrect: Rect?,
                   destinationRect dstrect: Rect?,
                   angle: Double,
                   center: Vector,
                   flip: RenderFlip) throws {
    let srcSDLRect: SDL_Rect? = srcrect.map { SDL_Rect.fromRect($0) }
    let dstSDLRect: SDL_Rect? = dstrect.map { SDL_Rect.fromRect($0) }
    var sdlCenterPtr = SDL_Point.fromPoint(center)

    let res = SDL_RenderCopyEx(self.handle, texture.handle, srcSDLRect.toPointer(), dstSDLRect.toPointer(),
                               angle, &sdlCenterPtr, flip.asSDL)
    assert(res == 0, "SDL_RenderCopyEx failed")
  }

  public func present() {
    SDL_RenderPresent(self.handle)
  }

  public func fill(usingRect rect: Rect) {
    var sdlRect: SDL_Rect = SDL_Rect.fromRect(rect)

    let res = SDL_RenderFillRect(self.handle, &sdlRect)
    assert(res == 0, "SDL_RenderFillRect failed")
  }

  public func draw(usingRect rect: Rect) {
    var sdlRect: SDL_Rect = SDL_Rect.fromRect(rect)

    let res = SDL_RenderDrawRect(self.handle, &sdlRect)
    assert(res == 0, "SDL_RenderDrawRect failed")
  }

  public func draw(startingFrom startPoint: Vector, endingAt endPoint: Vector) {
    let res = SDL_RenderDrawLine(self.handle, startPoint.x.int32, startPoint.y.int32,
        endPoint.x.int32, endPoint.y.int32)
    assert(res == 0, "SDL_RenderDrawLine failed")
  }

  public func draw(point point: Vector) {
    let res = SDL_RenderDrawPoint(self.handle, point.x.int32, point.y.int32)
    assert(res == 0, "SDL_RenderDrawPoint failed")
  }

  public var blendMode: SDL_BlendMode {
    set {
      let res = SDL_SetRenderDrawBlendMode(self.handle, newValue)
      assert(res == 0, "SDL_SetRenderDrawBlendMode failed")
    }
    get {
      var mode: SDL_BlendMode = SDL_BlendMode(0)

      let res = SDL_GetRenderDrawBlendMode(self.handle, &mode)
      assert(res == 0, "SDL_GetRenderDrawBlendMode failed")

      return mode
    }
  }

  public var drawColour: Colour {
    get {
      var r: UInt8 = 0, g: UInt8 = 0, b: UInt8 = 0, a: UInt8 = 0

      let res = SDL_GetRenderDrawColor(self.handle, &r, &g, &b, &a)
      assert(res == 0, "SDL_GetRenderDrawColor failed")

      return Colour(rgba:(r,g,b,a))
    }
    set {
      let res = SDL_SetRenderDrawColor(self.handle, newValue.r, newValue.g, newValue.b, newValue.a)
      assert(res == 0, "SDL_SetRenderDrawColor failed")
    }
  }

  public var scale: Size {
    get {
      var w: Float = 0.00, h: Float = 0.00

      SDL_RenderGetScale(self.handle, &w, &h)

      return Size(sizeX: Double(w), sizeY: Double(h))
    }
    set {
      SDL_RenderSetScale(self.handle, Float(newValue.sizeX), Float(newValue.sizeY))
    }
  }

  public var clipEnabled : Bool {
    return SDL_RenderIsClipEnabled(self.handle) == SDL_TRUE
  }

  public var logicalSize: Size {
    get {
      var w: Int32 = 0, h: Int32 = 0

      SDL_RenderGetLogicalSize(self.handle, &w, &h)

      return Size(sizeX: w, sizeY: h)
    }
    set {
      SDL_RenderSetLogicalSize(self.handle, newValue.sizeX.int32, newValue.sizeY.int32)
    }
  }

  /*
   * SDL_gfx
   */
  public func fillCircle(position position: Vector, rad: Int16, colour: Colour) {
    let res = filledCircleRGBA(self.handle, position.x.int16, position.y.int16, rad,
        colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "filledCircleColor failed")
  }

  public func drawPolygon(vx vx: Array<Int16>, vy: Array<Int16>, colour: Colour) {
    assert(vx.count == vy.count, "vx, vy lengths differ")

    let res = polygonRGBA(self.handle, vx, vy, Int32(vx.count), colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "polygonRGBA failed")
  }

  public func fillPolygon(vx vx: Array<Int16>, vy: Array<Int16>, colour: Colour) {
    assert(vx.count == vy.count, "vx, vy lengths differ")

    let res = filledPolygonRGBA(self.handle, vx, vy, Int32(vx.count), colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "filledPolygonRGBA failed")
  }

  public func fillThickLine(point1 point1: Vector, point2: Vector, width: UInt8, colour: Colour) {
    let res = thickLineRGBA(self.handle, point1.x.int16, point1.y.int16, point2.x.int16,
        point2.y.int16, width, colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "thickLineRGBA failed")
  }

  public func drawRoundedRectangle(point1 point1: Vector, point2: Vector, radius: Int16, colour: Colour) {
    let res = roundedRectangleRGBA(self.handle, point1.x.int16, point1.y.int16, point2.x.int16,
        point2.y.int16, radius, colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "roundedRectangleRGBA failed")
  }

  public func fillRoundedRectangle(point1 point1: Vector, point2: Vector, radius: Int16, colour: Colour) {
    let res = roundedBoxRGBA(self.handle, point1.x.int16, point1.y.int16, point2.x.int16,
        point2.y.int16, radius, colour.r, colour.g, colour.b, colour.a)

    assert(res == 0, "roundedBoxRGBA failed")
  }
}