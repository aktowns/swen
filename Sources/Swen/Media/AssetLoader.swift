//
//   AssetLoader.swift created on 28/12/15
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