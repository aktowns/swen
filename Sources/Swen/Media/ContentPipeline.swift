public class ContentPipeline {
  private let renderer: Renderer?

  var fontLoaders = Array<AssetFontLoader.Type>()
  var imageLoaders = Array<AssetImageLoader.Type>()
  var audioLoaders = Array<AssetAudioLoader.Type>()

  public init() {
    self.renderer = nil

    defaultLoaders()
  }

  public init(withRenderer renderer: Renderer) {
    self.renderer = renderer

    defaultLoaders()
  }

  public func get<Unhandled>(fromPath path: String) -> Unhandled? {
    return Optional.None
  }

  public func get(fromPath path: String) -> FontFile? {
    let loader: AssetFontLoader.Type? = fontLoaders.findFirst { $0.canHandle(path) }
    let loaderInst = loader?.init(withPath: path, andRenderer: renderer)

    return loaderInst?.load()
  }

  public func get(fromPath path: String) -> ImageFile? {
    let loader: AssetImageLoader.Type? = imageLoaders.findFirst { $0.canHandle(path) }
    let loaderInst = loader?.init(withPath: path, andRenderer: renderer)
    return loaderInst?.load()
  }

  public func get(fromPath path: String) -> AudioFile? {
    let loader: AssetAudioLoader.Type? = audioLoaders.findFirst { $0.canHandle(path) }
    let loaderInst = loader?.init(withPath: path)
    return loaderInst?.load()
  }

  private func defaultLoaders() {
    fontLoaders.append(FontLoader)
    imageLoaders.append(ImageLoader)
    audioLoaders.append(AudioLoader)
  }
}