//
//   Item.swift created on 30/12/15
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

import Swen

public class Item : GameLoop {
  private let pipeline: ContentPipeline

  var items: Texture
  var itemsMap: [String: Rect<Int32>]
  let walkingAnimation = ["coinBronze", "coinSilver", "coinGold"]
  var animationStep: Int = 0

  var position: Point<Int32> = Point(x: 920, y: 370)

  public init(pipeline: ContentPipeline, position: Point<Int32>) throws {
    self.pipeline = pipeline

    let itemsSpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_items.xml")!

    self.items = try itemsSpriteMap.imageFile.asTexture()
    self.itemsMap = itemsSpriteMap.mapping
    self.position = position
  }

  public func draw(game: Game) {
    items.render(atPoint: position, clip: itemsMap[walkingAnimation[self.animationStep / 6]]!)
  }

  public func loop(game: Game) {
    self.animationStep += 1
    if ((self.animationStep / 6) >= walkingAnimation.count) {
      self.animationStep = 0
    }
  }
}
