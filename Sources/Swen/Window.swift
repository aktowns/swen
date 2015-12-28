import CSDL

public class Window {
  typealias RawWindow = COpaquePointer

  let handle: RawWindow
  let renderer: Renderer

  init(handle: RawWindow) throws {
    if handle == nil {
      throw SDLError.BadHandleError(message: "Window.init handed a null pointer.")
    }

    self.handle = handle
    self.renderer = try Renderer(window: handle)
  }

  convenience init(withTitle title: String,
                   position: Point<Int32>,
                   size: Size<Int32>,
                   andFlags flags: UInt32) throws {

    // Hmm could possibly just use SDL_CreateWindowAndRenderer
    let window = SDL_CreateWindow(title, position.x, position.y, size.w, size.h, flags)

    assert(window != nil, "SDL_CreateWindow failed: \(SDL.getErrorMessage())")

    try self.init(handle: window)
  }

  convenience init(withTitle title: String, position: Point<Int32>, andSize size: Size<Int32>) throws {
    try self.init(withTitle: title, position: position, size: size, andFlags: SDL_WINDOW_SHOWN.rawValue)
  }

  convenience init(withTitle title: String,
                   andSize size: Size<Int32>) throws {
    let SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_MASK|0

    try self.init(withTitle: title,
                  position: Point(x: SDL_WINDOWPOS_UNDEFINED, y: SDL_WINDOWPOS_UNDEFINED),
                  andSize: size)
  }

  public var surface: Surface? {
    let windowSurface = SDL_GetWindowSurface(handle)
    return try? Surface(handle: windowSurface)
  }

  public func updateSurface() {
    let res = SDL_UpdateWindowSurface(handle)
    assert(res == 0, "SDL_UpdateWindowSurface failed")
  }

//  public var renderer: Renderer? {
//    let ptr = SDL_GetRenderer(handle)
//    return try? Renderer(fromHandle: ptr)
//  }
}
