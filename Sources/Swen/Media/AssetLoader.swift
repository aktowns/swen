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

public protocol AssetRenderableBaseLoader : AssetBaseLoader {
  init(withPath _: String, andRenderer: Renderer?)
}

public protocol AssetFontLoader : AssetRenderableBaseLoader {
  func load() -> FontFile
}

protocol AssetImageLoader : AssetRenderableBaseLoader {
  func load() -> ImageFile
}

protocol AssetAudioLoader : AssetBaseLoader {
  func load() -> AudioFile
}