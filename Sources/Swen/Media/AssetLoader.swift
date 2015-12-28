import Foundation

public enum AssetLoaderError : ErrorType {
  case InitialisationError(message: String)
  case OpenError(message: String)
  case ConfigKeyNotFound(message: String)
}

public protocol AssetBaseLoader {
  init(withPath _: String)

  static func canHandle(file: String) -> Bool

  func unload() -> Void
}

public protocol AssetFontLoader : AssetBaseLoader {
  func load() -> FontFile
}

protocol AssetImageLoader : AssetBaseLoader {
  func load() -> ImageFile
}

protocol AssetAudioLoader : AssetBaseLoader {
  func load() -> AudioFile
}