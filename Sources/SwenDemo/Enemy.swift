//
//   Enemy.swift created on 30/12/15
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

public class Enemy: GameLoop {
  private let pipeline: ContentPipeline

  var enemy: Texture
  var enemyMap: [String:Rect]
  let walkingAnimation = ["bee", "bee_move", "bee_dead"]
  var animationStep: Int = 0

  var position: Vector = Vector(x: 820.0, y: 290.0)

  public init(pipeline: ContentPipeline) throws {
    self.pipeline = pipeline

    let enemySpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_enemies.xml")!

    self.enemy = try enemySpriteMap.imageFile.asTexture()
    self.enemyMap = enemySpriteMap.mapping
  }

  public func draw(game: Game) {
    enemy.render(atPoint: position, clip: enemyMap[walkingAnimation[self.animationStep / 6]]!)
  }

  public func update(game: Game) {
    self.animationStep += 1
    if ((self.animationStep / 6) >= walkingAnimation.count) {
      self.animationStep = 0
    }
  }
}
