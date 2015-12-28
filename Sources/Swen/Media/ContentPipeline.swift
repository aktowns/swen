import Foundation

public class ContentPipeline {
  var fontLoaders = Array<AssetFontLoader.Type>()
  var imageLoaders = Array<AssetImageLoader.Type>()
  var audioLoaders = Array<AssetAudioLoader.Type>()

  init() {
    fontLoaders.append(FontLoader)
    imageLoaders.append(ImageLoader)
    audioLoaders.append(AudioLoader)
  }

  func get<Unhandled>(fromPath path: String) -> Unhandled? {
    return Optional.None
  }

  func get(fromPath path: String) -> FontFile? {
    let loader: AssetFontLoader.Type? = fontLoaders.findFirst {
      loader in loader.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path)
    return loaderInst?.load()
  }

  func get(fromPath path: String) -> ImageFile? {
    let loader: AssetImageLoader.Type? = imageLoaders.findFirst {
      loader in loader.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path)
    return loaderInst?.load()
  }

  func get(fromPath path: String) -> AudioFile? {
    let loader: AssetAudioLoader.Type? = audioLoaders.findFirst {
      loader in loader.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path)
    return loaderInst?.load()
  }
}