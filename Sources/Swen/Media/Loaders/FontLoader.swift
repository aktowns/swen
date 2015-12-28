import Foundation

public class FontLoader : AssetFontLoader {
  private let path: String

  public required init(withPath path: String) {
    self.path = path
  }

  public static func canHandle(file: String) -> Bool {
    return file.hasSuffix("ttf")
  }

  public func load() -> FontFile {
    return FontFile(fromPath: self.path)
  }

  public func unload() {

  }
}