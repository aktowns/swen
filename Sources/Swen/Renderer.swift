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
  typealias RawRenderer = COpaquePointer

  let handle: RawRenderer

  init(window: Window.RawWindow, index: Int32, flags: RenderFlags) throws {
    self.handle = SDL_CreateRenderer(window, index, flags.rawValue)

    if self.handle == nil {
      throw SDLError.RendererCreationError(message: SDL.getErrorMessage())
    }
  }

  convenience init(window: Window.RawWindow) throws {
    try self.init(window: window, index: -1, flags: RenderFlags.Accelerated)
  }

  init(fromHandle handle: RawRenderer) throws {
    self.handle = handle

    if self.handle == nil {
      throw SDLError.RendererCreationError(message: SDL.getErrorMessage())
    }
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
                   sourceRect srcrect: Rect<Int32>?,
                   destinationRect dstrect: Rect<Int32>?) {
    let srcSDLRect: SDL_Rect? = srcrect.map { SDL_Rect.fromRect($0) }
    let dstSDLRect: SDL_Rect? = dstrect.map { SDL_Rect.fromRect($0) }

    let res = SDL_RenderCopy(self.handle, texture.handle, srcSDLRect.toPointer(), dstSDLRect.toPointer())
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

  public func present() {
    SDL_RenderPresent(self.handle)
  }

  public func fill(usingRect rect: Rect<Int32>) {
    var sdlRect: SDL_Rect = SDL_Rect.fromRect(rect)

    let res = SDL_RenderFillRect(self.handle, &sdlRect)
    assert(res == 0, "SDL_RenderFillRect failed")
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