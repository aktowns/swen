import CSDL

public class SDLExtensionTTF : SDLExtension {
  public func prepare() throws {
    if TTF_Init() < 0 {
      throw SDLError.InitialisationError(message: "TTF_Init: \(SDL.getErrorMessage())")
    }
  }

  public func quit() {
    TTF_Quit()
  }
}