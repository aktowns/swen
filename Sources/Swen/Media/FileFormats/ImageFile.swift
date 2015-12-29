import CSDL

public class ImageFile {
  let renderer: Renderer?
  let path: String

  init(fromPath path: String, andRenderer renderer: Renderer?) {
    self.renderer = renderer
    self.path = path
  }

  // MARK: - exporters
  public func asTexture() throws -> Texture {
    guard let render = renderer else {
      fatalError("ImageFile.asTexture() called without a renderer specified, maybe try " +
          "ImageFile.asTexture(withRenderer:) or specify a renderer when intialising the content pipeline")
    }

    return try asTexture(withRenderer: render)
  }

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
