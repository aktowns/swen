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
                   sourceRect srcrect: Rect<Int32>) {
    var srcSDLRect = SDL_Rect.fromRect(srcrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, &srcSDLRect, nil)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture, destinationRect dstrect: Rect<Int32>) {
    var dstSDLRect = SDL_Rect.fromRect(dstrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, nil, &dstSDLRect)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture,
                   sourceRect srcrect: Rect<Int32>,
                   destinationRect dstrect: Rect<Int32>) {
    var srcSDLRect: SDL_Rect = SDL_Rect.fromRect(srcrect)
    var dstSDLRect: SDL_Rect = SDL_Rect.fromRect(dstrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, &srcSDLRect, &dstSDLRect)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture,
                   sourceRect srcrect: Rect<Int32>?,
                   destinationRect dstrect: Rect<Int32>?,
                   angle: Double,
                   center: Point<Int32>,
                   flip: RenderFlip) throws {
    let srcSDLRect: SDL_Rect? = srcrect.map { SDL_Rect.fromRect($0) }
    let dstSDLRect: SDL_Rect? = dstrect.map { SDL_Rect.fromRect($0) }
    var sdlCenterPtr = SDL_Point.fromPoint(center)

    let res = SDL_RenderCopyEx(self.handle, texture.handle, srcSDLRect.toPointer(), dstSDLRect.toPointer(),
                               angle, &sdlCenterPtr, flip.asSDL)
    assert(res == 0, "SDL_RenderCopyEx failed")
  }

  public func copy(texture texture: Texture, sourceRect srcrect: Rect<Double>) {
    var srcSDLRect = SDL_Rect.fromRect(srcrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, &srcSDLRect, nil)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func copy(texture texture: Texture, destinationRect dstrect: Rect<Double>) {
    var dstSDLRect = SDL_Rect.fromRect(dstrect)

    let res = SDL_RenderCopy(self.handle, texture.handle, nil, &dstSDLRect)
    assert(res == 0, "SDL_RenderCopy failed")
  }

  public func present() {
    SDL_RenderPresent(self.handle)
  }

  public func fill(usingRect rect: Rect<Int32>) {
    var sdlRect: SDL_Rect = SDL_Rect.fromRect(rect)

    let res = SDL_RenderFillRect(self.handle, &sdlRect)
    assert(res == 0, "SDL_RenderFillRect failed")
  }

  public func fillCircle(position: Point<Int16>, rad: Int16, colour: Colour) {
    let res = filledCircleRGBA(self.handle, position.x, position.y, rad, colour.r, colour.g, colour.b, colour.a ?? 0)
    assert(res == 0, "filledCircleColor failed")
  }

  public func draw(usingRect rect: Rect<Int32>) {
    var sdlRect: SDL_Rect = SDL_Rect.fromRect(rect)

    let res = SDL_RenderDrawRect(self.handle, &sdlRect)
    assert(res == 0, "SDL_RenderDrawRect failed")
  }

  public func draw(startingFrom startPoint: Point<Int32>, endingAt endPoint: Point<Int32>) {
    let res = SDL_RenderDrawLine(self.handle, startPoint.x, startPoint.y, endPoint.x, endPoint.y)
    assert(res == 0, "SDL_RenderDrawLine failed")
  }

  public func draw(point point: Point<Int32>) {
    let res = SDL_RenderDrawPoint(self.handle, point.x, point.y)
    assert(res == 0, "SDL_RenderDrawPoint failed")
  }

  var blendMode: SDL_BlendMode {
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

  var drawColour: Colour {
    get {
      var r: UInt8 = 0, g: UInt8 = 0, b: UInt8 = 0, a: UInt8 = 0

      let res = SDL_GetRenderDrawColor(self.handle, &r, &g, &b, &a)
      assert(res == 0, "SDL_GetRenderDrawColor failed")

      return Colour(r: r, g: g, b: b, a: a)
    }
    set {
      let res = SDL_SetRenderDrawColor(self.handle, newValue.r, newValue.g, newValue.b, newValue.a ?? 0)
      assert(res == 0, "SDL_SetRenderDrawColor failed")
    }
  }

  var scale: Size<Float> {
    get {
      var w: Float = 0.00, h: Float = 0.00

      SDL_RenderGetScale(self.handle, &w, &h)

      return Size(w: w, h: h)
    }
    set {
      SDL_RenderSetScale(self.handle, newValue.w, newValue.h)
    }
  }

  var clipEnabled : Bool {
    return SDL_RenderIsClipEnabled(self.handle) == SDL_TRUE
  }

  var logicalSize: Size<Int32> {
    get {
      var w: Int32 = 0, h: Int32 = 0

      SDL_RenderGetLogicalSize(self.handle, &w, &h)

      return Size(w: w, h: h)
    }
    set {
      SDL_RenderSetLogicalSize(self.handle, newValue.w, newValue.h)
    }
  }
}