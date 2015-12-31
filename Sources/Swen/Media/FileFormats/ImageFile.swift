//
//   ImageFile.swift created on 28/12/15
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

import CSDL

public class ImageFile : FileType {
  let renderer: Renderer?
  let path: String

  init(fromPath path: String, andRenderer renderer: Renderer?) {
    self.renderer = renderer
    self.path = path
  }

  // MARK: - exporters
  public func asTexture() throws -> Texture {
    guard let render = renderer else {
      fatalError("ImageFile.asTexture() called without a renderer specified, maybe try " +
          "ImageFile.asTexture(withRenderer:) or specify a renderer when intialising the content pipeline")
    }

    return try asTexture(withRenderer: render)
  }

  public func asTexture(withRenderer renderer: Renderer) throws -> Texture {
    let texPtr = IMG_LoadTexture(renderer.handle, self.path)

    if texPtr == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    return Texture(fromHandle: texPtr, andRenderer: renderer)
  }

  public func asSurface() throws -> Surface {
    let img = IMG_Load(path)

    if img == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    return Surface(fromHandle: img)
  }

}
