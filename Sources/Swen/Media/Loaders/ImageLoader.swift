import Foundation

public class ImageLoader : AssetImageLoader {
  private let path: String
  private let renderer: Renderer?

  public required init(withPath path: String) {
    self.path = path
    self.renderer = nil
  }

  public required init(withPath path: String, andRenderer renderer: Renderer?) {
    self.path = path
    self.renderer = renderer
  }

  public static func canHandle(file: String) -> Bool {
    return file.hasSuffix("png") || file.hasSuffix("jpg") || file.hasSuffix("tif")
  }

  public func load() -> ImageFile {
    return ImageFile(fromPath: self.path, andRenderer: renderer)
  }

  public func unload() -> Void {

  }
}