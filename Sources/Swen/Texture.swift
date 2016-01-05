//
//   Texture.swift created on 27/12/15
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

public class Texture {
  public typealias RawTexture = COpaquePointer

  let handle: RawTexture
  public let renderer: Renderer

  /// Create a texture from a raw handle
  public init(fromHandle handle: RawTexture, andRenderer renderer: Renderer) {
    assert(handle != nil, "Texture.init(fromHandle:andRenderer) given a null handle")

    self.handle = handle
    self.renderer = renderer
  }

  /// Create a texture for a rendering context.
  public convenience init(withRenderer renderer: Renderer,
                          format: UInt32,
                          access: Int32,
                          andSize size: Size) throws {
    let ptr = SDL_CreateTexture(renderer.handle, format, access, size.sizeX.int32, size.sizeY.int32)

    if ptr == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    self.init(fromHandle: ptr, andRenderer: renderer)
  }

  /// Create a texture from an existing surface.
  public convenience init(fromSurface surface: Surface, withRenderer renderer: Renderer) throws {
    let ptr = SDL_CreateTextureFromSurface(renderer.handle, surface.handle)

    if ptr == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    self.init(fromHandle: ptr, andRenderer: renderer)
  }

  deinit {
    SDL_DestroyTexture(handle)
  }

  public func render() {
    renderer.copy(texture: self)
  }

  public func render(atPoint point: Vector) {
    let destRect = Rect(x: point.x, y: point.y, sizeX: self.size.sizeX, sizeY: self.size.sizeY)

    renderer.copy(texture: self, destinationRect: destRect)
  }

  public func render(atPoint point: Vector, clip: Rect) {
    let destRect = Rect(x: point.x, y: point.y, sizeX: clip.sizeX, sizeY: clip.sizeY)

    renderer.copy(texture: self, sourceRect: clip, destinationRect: destRect)
  }

  public var colourMod: Colour {
    get {
      var r: UInt8 = 0, g: UInt8 = 0, b: UInt8 = 0

      let res = SDL_GetTextureColorMod(self.handle, &r, &g, &b)
      assert(res == 0, "SDL_GetTextureColorMod failed")

      return Colour(rgb: (r, g, b))
    }
    set {
      let res = SDL_SetTextureColorMod(self.handle, newValue.r, newValue.g, newValue.b)
      assert(res == 0, "SDL_SetTextureColorMod failed")
    }
  }

  public var blendMode: SDL_BlendMode {
    set {
      let res = SDL_SetTextureBlendMode(self.handle, newValue)
      assert(res == 0, "SDL_SetTextureBlendMode failed")
    }
    get {
      let mode = UnsafeMutablePointer<SDL_BlendMode>.alloc(1)
      let res = SDL_GetTextureBlendMode(self.handle, mode)
      assert(res == 0, "SDL_GetTextureBlendMode failed")

      return mode.memory
    }
  }

  public var alpha: UInt8 {
    set {
      let res = SDL_SetTextureAlphaMod(self.handle, newValue)
      assert(res == 0, "SDL_SetTextureAlphaMod failed")
    }
    get {
      let alpha = UnsafeMutablePointer<UInt8>.alloc(1)

      let res = SDL_GetTextureAlphaMod(self.handle, alpha)
      assert(res == 0, "SDL_GetTextureAlphaMod failed")

      return alpha.memory
    }
  }

  public var size: Size {
    get {
      var w: Int32 = 0, h: Int32 = 0

      let res = SDL_QueryTexture(self.handle, nil, nil, &w, &h)
      assert(res == 0, "SDL_QueryTexture failed")

      return Size(sizeX: w, sizeY: h)
    }
  }
}
