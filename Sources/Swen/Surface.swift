//
//   Surface.swift created on 27/12/15
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

public class Surface {
  public typealias RawSurface = UnsafeMutablePointer<SDL_Surface>

  let handle: RawSurface

  public init(fromHandle handle: RawSurface) {
    assert(handle != nil, "Surface.init(fromHandle:) given a null handle")

    self.handle = handle
  }

  /*
  SDL_Surface* SDL_CreateRGBSurface(Uint32 flags,
                                  int    width,
                                  int    height,
                                  int    depth,
                                  Uint32 Rmask,
                                  Uint32 Gmask,
                                  Uint32 Bmask,
                                  Uint32 Amask)
  */

  public convenience init(size: Size) {
    let ptr = SDL_CreateRGBSurface(0, Int32(size.sizeX), Int32(size.sizeY),
        32, 0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff)

    self.init(fromHandle: ptr)
  }

  deinit {
    SDL_FreeSurface(self.handle)
  }

  public var format: UnsafeMutablePointer<SDL_PixelFormat> {
    return self.handle.memory.format
  }

  public var size: Size {
    return Size(sizeX: self.handle.memory.w, sizeY: self.handle.memory.h)
  }

  public var pitch: Int32 {
    return self.handle.memory.pitch
  }

  public func blit(source src: Surface, sourceRect srcrect: Rect?) {
    blit(source: src, sourceRect: srcrect, destRect: nil)
  }

  public func blit(source src: Surface, sourceRect srcrect: Rect?, destRect dstrect: Rect?) {
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

    return Surface(fromHandle: surf)
  }

  public func rotozoom(angle angle: Double, zoom: Double, smooth: Bool) -> Surface {
    let ptr = rotozoomSurface(self.handle, angle, zoom, smooth ? 1 : 0)

    return Surface(fromHandle: ptr)
  }

  public var colourKey: UInt32 {
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
