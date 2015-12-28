import CSDL

public class ImageFile {
  let path: String

  init(fromPath path: String) {
    self.path = path
  }

  // MARK: - exporters
  public func asTexture(withRenderer renderer: Renderer) throws -> Texture {
    let texPtr = IMG_LoadTexture(renderer.handle, self.path)

    if texPtr == nil {
      throw SDLError.MediaLoadError(message: SDL.getErrorMessage())
    }

    return try Texture(fromHandle: texPtr, andRenderer: renderer)
  }

  public func asSurface() throws -> Surface {
    let img = IMG_Load(path)

    if img == nil {
      throw SDLError.MediaLoadError(message: SDL.getErrorMessage())
    }

    return try Surface(handle: img)
  }

}
