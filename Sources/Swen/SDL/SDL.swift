import CSDL

public class SDL {
  public class func initSDL() throws -> Void {
    try SDLExtensionLoader.loadAll()
    try SDLExtensionLoader.prepareAll()
  }

  public class func quitSDL() -> Void {
    SDLExtensionLoader.quitAll()
  }

  class func getErrorMessage() -> String {
    let errorStr = String.fromCString(SDL_GetError())
    return errorStr ?? "Unexpected Error"
  }

  public class func delay(ms ms: UInt32) -> Void {
    SDL_Delay(ms)
  }
}
