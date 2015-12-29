//
//   ImageLoader.swift created on 28/12/15
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