import CSDL

public class Surface {
  typealias RawSurface = UnsafeMutablePointer<SDL_Surface>

  let handle: RawSurface

  init(handle: RawSurface) throws {
    if handle == nil {
      print("Surface.Init: Bad Handle")
      throw SDLError.BadHandleError(message: "Surface.init")
    }

    self.handle = handle
  }

  public var format: UnsafeMutablePointer<SDL_PixelFormat> {
    return self.handle.memory.format
  }

  public var size: Size<Int32> {
    return Size(w: self.handle.memory.w, h: self.handle.memory.h)
  }

  public var pitch: Int32 {
    return self.handle.memory.pitch
  }

  public func blit(source src: Surface, sourceRect srcrect: Rect<Int32>?) {
    blit(source: src, sourceRect: srcrect, destRect: nil)
  }

  public func blit(source src: Surface, sourceRect srcrect: Rect<Int32>?, destRect dstrect: Rect<Int32>?) {
    var srcRectptr = UnsafeMutablePointer<SDL_Rect>.alloc(1)
    var dstRectptr = UnsafeMutablePointer<SDL_Rect>.alloc(1)

    if let rect = srcrect {
      let sdlRect = SDL_Rect.fromRect(rect)
      srcRectptr.initialize(sdlRect)
    } else {
      srcRectptr = nil
    }

    if let rect = dstrect {
      let sdlRect = SDL_Rect.fromRect(rect)
      dstRectptr.initialize(sdlRect)
    } else {
      dstRectptr = nil
    }

    let res = SDL_UpperBlit(src.handle, srcRectptr, self.handle, dstRectptr)
    assert(res == 0, "SDL_UpperBlit failed")
  }

  public func convert(format format: UnsafePointer<SDL_PixelFormat>) throws -> Surface {
    let surf = SDL_ConvertSurface(self.handle, format, 0)

    if surf == nil {
      throw SDLError.ConvertSurfaceError(message: SDL.getErrorMessage())
    }

    return try Surface(handle: surf)
  }

  var colourKey: UInt32 {
    get {
      var key: UInt32 = 0

      let res = SDL_GetColorKey(self.handle, &key)
      assert(res == 0, "SDL_GetColorKey failed")

      return key
    }
  }

  public func enableColourKey(key: UInt32) {
    let res = SDL_SetColorKey(self.handle, 1, key)
    assert(res == 0, "SDL_SetColorKey failed")
  }

  public func disableColourKey(key: UInt32) {
    let res = SDL_SetColorKey(self.handle, 0, key)
    assert(res == 0, "SDL_SetColorKey")
  }
}
