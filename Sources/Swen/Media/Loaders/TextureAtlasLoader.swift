//
//   TextureAtlasLoader.swift created on 30/12/15
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

/*
 * Support for Sparrow exported texture atlas files into groups of named textures
 */

import Foundation

public class TextureAtlasLoader: AssetImageMapLoader {
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
    return file.hasSuffix("xml")
  }

  public func load() -> ImageMapFile {
    let xmlDoc = XPathDocument(withPath: path)
    let basePath = NSString(string: path).stringByDeletingLastPathComponent

    let mapping = createMapping(xmlDoc)
    let imageFilePath = documentImagePath(xmlDoc, basePath: basePath)
    let imageFile = ImageFile(fromPath: imageFilePath!, andRenderer: renderer)

    return ImageMapFile(imageFile: imageFile, mapping: mapping)
  }

  public func unload() -> Void {

  }

  private func documentImagePath(xmlDoc: XPathDocument, basePath: String) -> String? {
    let atlasNodes = xmlDoc.search(withXPath: "/TextureAtlas")
    if atlasNodes.count > 0 {
      if let imageName = atlasNodes[0].getProp("imagePath") {
        return basePath + "/" + imageName
      }
    }

    return Optional.None
  }

  private func createMapping(xmlDoc: XPathDocument) -> [String: Rect] {
    let nodes = xmlDoc.search(withXPath: "/TextureAtlas/SubTexture")

    var retDict = Dictionary<String, Rect>()

    for node in nodes {
      let name = node.getProp("name")!
      let x = node.getProp("x")!
      let y = node.getProp("y")!
      let width = node.getProp("width")!
      let height = node.getProp("height")!

      let rect = Rect(x: Double(x)!, y: Double(y)!, sizeX: Double(width)!, sizeY: Double(height)!)

      retDict[name] = rect
    }

    return retDict
  }

}
