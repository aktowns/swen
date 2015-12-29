import CSDL

public struct WindowFlags : OptionSetType {
  public let rawValue: UInt32

  public init(rawValue: UInt32) {
    self.rawValue = rawValue
  }

  static let Fullscreen         = WindowFlags(rawValue: SDL_WINDOW_FULLSCREEN.rawValue)
  static let OpenGL             = WindowFlags(rawValue: SDL_WINDOW_OPENGL.rawValue)
  static let Shown              = WindowFlags(rawValue: SDL_WINDOW_SHOWN.rawValue)
  static let Hidden             = WindowFlags(rawValue: SDL_WINDOW_HIDDEN.rawValue)
  static let Borderless         = WindowFlags(rawValue: SDL_WINDOW_BORDERLESS.rawValue)
  static let Resizable          = WindowFlags(rawValue: SDL_WINDOW_RESIZABLE.rawValue)
  static let Minimised          = WindowFlags(rawValue: SDL_WINDOW_MINIMIZED.rawValue)
  static let Maximised          = WindowFlags(rawValue: SDL_WINDOW_MAXIMIZED.rawValue)
  static let InputGrabbed       = WindowFlags(rawValue: SDL_WINDOW_INPUT_GRABBED.rawValue)
  static let InputFocus         = WindowFlags(rawValue: SDL_WINDOW_INPUT_FOCUS.rawValue)
  static let MouseFocus         = WindowFlags(rawValue: SDL_WINDOW_MOUSE_FOCUS.rawValue)
  static let FullscreenDesktop  = WindowFlags(rawValue: SDL_WINDOW_FULLSCREEN_DESKTOP.rawValue)
  static let Foreign            = WindowFlags(rawValue: SDL_WINDOW_FOREIGN.rawValue)
  static let AllowHighDPI       = WindowFlags(rawValue: SDL_WINDOW_ALLOW_HIGHDPI.rawValue)
  static let MouseCapture       = WindowFlags(rawValue: SDL_WINDOW_MOUSE_CAPTURE.rawValue)
}

let WindowPosUndefined = SDL_WINDOWPOS_UNDEFINED_MASK|0
let WindowPosCentered  = SDL_WINDOWPOS_CENTERED_MASK|0

public class Window {
  public typealias RawWindow = COpaquePointer

  let handle: RawWindow
  public let renderer: Renderer

  public init(fromHandle handle: RawWindow) throws {
    assert(handle != nil, "Window.init handed a null pointer.")

    self.handle = handle
    self.renderer = try Renderer(forWindowHandle: handle)
  }

  public convenience init(withTitle title: String,
                   position: Point<Int32>,
                   size: Size<Int32>,
                   andFlags flags: WindowFlags) throws {

    // Hmm could possibly just use SDL_CreateWindowAndRenderer
    let window = SDL_CreateWindow(title, position.x, position.y, size.w, size.h, flags.rawValue)

    assert(window != nil, "SDL_CreateWindow failed: \(SDL.getErrorMessage())")

    try self.init(fromHandle: window)
  }

  public convenience init(withTitle title: String, position: Point<Int32>, andSize size: Size<Int32>) throws {
    try self.init(withTitle: title,
                  position: position,
                  size: size,
                  andFlags: [WindowFlags.Shown, WindowFlags.AllowHighDPI])
  }

  public convenience init(withTitle title: String,
                   andSize size: Size<Int32>) throws {
    try self.init(withTitle: title,
                  position: Point(x: WindowPosUndefined, y: WindowPosUndefined),
                  andSize: size)
  }

  public var surface: Surface {
    let windowSurface = SDL_GetWindowSurface(handle)
    return Surface(fromHandle: windowSurface)
  }

  public func updateSurface() {
    let res = SDL_UpdateWindowSurface(handle)
    assert(res == 0, "SDL_UpdateWindowSurface failed")
  }

  public var size: Size<Int32> {
    get {
      var w: Int32 = 0
      var h: Int32 = 0

      SDL_GetWindowSize(self.handle, &w, &h)

      return Size<Int32>(w: w, h: h)
    }
    set {
      SDL_SetWindowSize(self.handle, newValue.w, newValue.h)
    }
  }
}
