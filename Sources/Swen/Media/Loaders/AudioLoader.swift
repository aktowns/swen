import Foundation

public class AudioLoader : AssetAudioLoader {
  private let path: String

  public required init(withPath path: String) {
    self.path = path
  }

  public static func canHandle(file: String) -> Bool {
    return file.hasSuffix("mp3") || file.hasPrefix("wav") || file.hasPrefix("ogg")
  }

  public func load() -> AudioFile {
    return AudioFile(fromPath: self.path)
  }

  public func unload() {

  }
}