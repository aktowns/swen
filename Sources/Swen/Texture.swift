import CSDL

public class Texture {
  typealias RawTexture = COpaquePointer

  let handle: RawTexture
  private let renderer: Renderer

  /// Create a texture for a rendering context.
  init(withRenderer renderer: Renderer, format: UInt32, access: Int32, andSize size: Size<Int32>) throws {
    self.handle = SDL_CreateTexture(renderer.handle, format, access, size.w, size.h)
    self.renderer = renderer

    if self.handle == nil {
      throw SDLError.MediaLoadError(message: SDL.getErrorMessage())
    }
  }

  /// Create a texture from an existing surface.
  init(fromSurface surface: Surface, withRenderer renderer: Renderer) throws {
    self.handle = SDL_CreateTextureFromSurface(renderer.handle, surface.handle)
    self.renderer = renderer

    if self.handle == nil {
      throw SDLError.MediaLoadError(message: SDL.getErrorMessage())
    }
  }

  /// Create a texture from a raw handle
  init(fromHandle handle: RawTexture, andRenderer renderer: Renderer) throws {
    self.handle = handle
    self.renderer = renderer

    if self.handle == nil {
      throw SDLError.BadHandleError(message: "Texture.init(fromHandle:andRenderer:) given a null handle")
    }
  }

  deinit {
    SDL_DestroyTexture(self.handle)
  }

  public func render() {
    self.renderer.copy(texture: self)
  }

  public func render(atPoint point: Point<Int32>) {
    let destRect = Rect(x: point.x, y: point.y, sizeX: self.size.w, sizeY: self.size.h)

    self.renderer.copy(texture: self, sourceRect: nil, destinationRect: destRect)
  }

  public func render(atPoint point: Point<Int32>, clip: Rect<Int32>) {
    let destRect = Rect(x: point.x, y: point.y, sizeX: self.size.w, sizeY: self.size.h)

    self.renderer.copy(texture: self,  sourceRect: clip, destinationRect: destRect)
  }

  var colourMod: Colour {
    get {
      var r: UInt8 = 0, g: UInt8 = 0, b: UInt8 = 0

      let res = SDL_GetTextureColorMod(self.handle, &r, &g, &b)
      assert(res == 0, "SDL_GetTextureColorMod failed")

      return Colour(r: r, g: g, b: b, a: nil)
    }
    set {
      let res = SDL_SetTextureColorMod(self.handle, newValue.r, newValue.g, newValue.b)
      assert(res == 0, "SDL_SetTextureColorMod failed")
    }
  }

  var blendMode: SDL_BlendMode {
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

  var alpha: UInt8 {
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

  var size: Size<Int32> {
    get {
      var w: Int32 = 0, h: Int32 = 0

      let res = SDL_QueryTexture(self.handle, nil, nil, &w, &h)
      assert(res == 0, "SDL_QueryTexture failed")

      return Size(w: w, h: h)
    }
  }

}