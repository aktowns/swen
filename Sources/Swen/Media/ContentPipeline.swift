//
//   ContentPipeline.swift created on 28/12/15
//   Swen project
//
//   Copyright 2015 Ashley Towns <code@ashleytowns.id.au>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

public class ContentPipeline {
  public let renderer: Renderer?

  var fontLoaders = Array<AssetFontLoader.Type>()
  var imageLoaders = Array<AssetImageLoader.Type>()
  var audioLoaders = Array<AssetAudioLoader.Type>()
  var imageMapLoaders = Array<AssetImageMapLoader.Type>()

  public init() {
    self.renderer = nil

    defaultLoaders()
  }

  public init(withRenderer renderer: Renderer) {
    self.renderer = renderer

    defaultLoaders()
  }

  public func get<Unhandled>(fromPath path: String) -> Unhandled? {
    print("ContentPipeline.get(fromPath:) unable to handle: \(path)")
    return Optional.None
  }

  public func get(fromPath path: String) -> FontFile? {
    let loader: AssetFontLoader.Type? = fontLoaders.findFirst {
      $0.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path, andRenderer: renderer)

    return loaderInst?.load()
  }

  public func get(fromPath path: String) -> ImageMapFile? {
    let loader: AssetImageMapLoader.Type? = imageMapLoaders.findFirst {
      $0.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path, andRenderer: renderer)

    return loaderInst?.load()
  }

  public func get(fromPath path: String) -> ImageFile? {
    let loader: AssetImageLoader.Type? = imageLoaders.findFirst {
      $0.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path, andRenderer: renderer)
    return loaderInst?.load()
  }

  public func get(fromPath path: String) -> AudioFile? {
    let loader: AssetAudioLoader.Type? = audioLoaders.findFirst {
      $0.canHandle(path)
    }
    let loaderInst = loader?.init(withPath: path)
    return loaderInst?.load()
  }

  private func defaultLoaders() {
    fontLoaders.append(FontLoader)
    imageLoaders.append(ImageLoader)
    imageMapLoaders.append(TextureAtlasLoader)
    audioLoaders.append(AudioLoader)
  }

}
