import CSDL

public class SDLExtensionNet : SDLExtension {
  public func prepare() throws {
    if SDLNet_Init() < 0 {
      throw SDLError.InitialisationError(message: "SDLNet_Init: \(SDL.getErrorMessage())")
    }
  }

  public func quit() {
    SDLNet_Quit()
  }
}