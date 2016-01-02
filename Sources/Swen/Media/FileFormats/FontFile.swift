//
//   FontFile.swift created on 28/12/15
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

public class FontFile: FileType {
  let renderer: Renderer?
  let path: String

  init(fromPath path: String, andRenderer renderer: Renderer?) {
    self.path = path
    self.renderer = renderer
  }

  // MARK: - exporters
  public func asTexture(withText text: String,
                        size: Int32,
                        andColour colour: Colour) throws -> Texture {

    guard let render = renderer else {
      fatalError("FontFile.asTexture(withText:size:andColour) called without a renderer specified, maybe try " +
          "FontFile.asTexture(withText:size:colour:andRenderer:) or specify a renderer when intialising the " +
          "content pipeline")
    }

    return try asTexture(withText: text, size: size, colour: colour, andRenderer: render)
  }

  public func asTexture(withText text: String,
                        size: Int32,
                        colour: Colour,
                        andRenderer renderer: Renderer) throws -> Texture {
    let surface = try asSurface(withText: text, size: size, andColour: colour)
    return try Texture(fromSurface: surface, withRenderer: renderer)
  }

  public func asSurface(withText text: String, size: Int32, andColour colour: Colour) throws -> Surface {
    let ptr = try getPointer(withSize: size)

    let surface = TTF_RenderText_Solid(ptr, text, SDL_Color.fromColour(colour))
    return Surface(fromHandle: surface)
  }

  // MARK: - private
  private func getPointer(withSize size: Int32) throws -> COpaquePointer {
    let font = TTF_OpenFont(self.path, size)

    if font == nil {
      throw SDLError.UnexpectedNullPointer(message: SDL.getErrorMessage())
    }

    return font
  }
}
