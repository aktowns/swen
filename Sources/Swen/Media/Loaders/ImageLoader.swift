import Foundation

public class ImageLoader : AssetImageLoader {
  private let path: String

  public required init(withPath path: String) {
    self.path = path
  }

  public static func canHandle(file: String) -> Bool {
    return file.hasSuffix("png") || file.hasSuffix("jpg") || file.hasSuffix("tif")
  }

  public func load() -> ImageFile {
    return ImageFile(fromPath: self.path)
  }

  public func unload() -> Void {

  }
}