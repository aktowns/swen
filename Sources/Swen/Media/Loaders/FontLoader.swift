import Foundation

public class FontLoader : AssetFontLoader {
  private let renderer: Renderer?
  private let path: String

  public required init(withPath path: String) {
    self.path = path
    self.renderer = nil
  }

  public required init(withPath path: String, andRenderer renderer: Renderer?) {
    self.path = path
    self.renderer = renderer
  }

  public static func canHandle(file: String) -> Bool {
    return file.hasSuffix("ttf")
  }

  public func load() -> FontFile {
    return FontFile(fromPath: self.path, andRenderer: renderer)
  }

  public func unload() {

  }
}