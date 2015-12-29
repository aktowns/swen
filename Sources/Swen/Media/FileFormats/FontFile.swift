import CSDL

public class FontFile {
  let renderer: Renderer?
  let path: String

  init(fromPath path: String, andRenderer renderer: Renderer?) {
    self.path = path
    self.renderer = renderer
  }

  // MARK: - exporters
  public func asTexture(withText text: String,
                        size: Int32,
                        andColour colour: Colour) throws -> Texture {

    guard let render = renderer else {
      fatalError("FontFile.asTexture(withText:size:andColour) called without a renderer specified, maybe try " +
          "FontFile.asTexture(withText:size:colour:andRenderer:) or specify a renderer when intialising the " +
          "content pipeline")
    }

    return try asTexture(withText: text, size: size, colour: colour, andRenderer: render)
  }

  public func asTexture(withText text: String,
                        size: Int32,
                        colour: Colour,
                        andRenderer renderer: Renderer) throws -> Texture {
    let surface = try asSurface(withText: text, size: size, andColour: colour)
    return try Texture(fromSurface: surface, withRenderer: renderer)
  }

  public func asSurface(withText text: String, size: Int32, andColour colour: Colour) throws -> Surface {
    let ptr = try getPointer(withSize: size)

    let surface = TTF_RenderText_Solid(ptr, text, SDL_Color.fromColour(colour))
    return try Surface(handle: surface)
  }

  // MARK: - private
  private func getPointer(withSize size: Int32) throws -> COpaquePointer {
    let font = TTF_OpenFont(self.path, size)

    if font == nil {
      throw SDLError.MediaLoadError(message: SDL.getErrorMessage())
    }

    return font
  }
}