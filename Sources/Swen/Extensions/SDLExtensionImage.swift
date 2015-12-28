import CSDL

public class SDLExtensionImage : SDLExtension {
  let flags: Int32

  let defaultFlags: UInt32 = IMG_INIT_JPG.rawValue
      | IMG_INIT_PNG.rawValue
      | IMG_INIT_TIF.rawValue

  init() {
    self.flags = Int32(defaultFlags)
  }

  init(flags: UInt32) {
    self.flags = Int32(flags)
  }

  public func prepare() throws {
    if (IMG_Init(flags) & flags) == 0 {
      throw SDLError.InitialisationError(message: "IMG_Init: \(SDL.getErrorMessage())")
    }
  }

  public func start() throws { }

  public func quit() {
    IMG_Quit()
  }
}