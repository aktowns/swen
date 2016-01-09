//
//   Player.swift created on 29/12/15
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

public class Player: Sprite, GameLoop {
  let walkingAnimation = ["alienBlue_walk1", "alienBlue_stand", "alienBlue_walk2"]

  var player: Texture?
  var playerMap: [String: Rect] = [:]
  var animationStep: Int = 0
  var playerVelocity: Int = 20

  public override func setup() {
    let playerSpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_players.xml")!

    self.player = try? playerSpriteMap.imageFile.asTexture()
    self.playerMap = playerSpriteMap.mapping

    let anim = playerMap[walkingAnimation[animationStep]]!

    self.size = anim.size
    self.position = Vector(x: 300, y: 300)
  }

  public func draw(game: Game) {
    let animation = playerMap[walkingAnimation[self.animationStep / 8]]
    player!.render(atPoint: position, clip: animation!)
  }

  public func update(game: Game) {
    self.animationStep += 1
    if (self.animationStep / 8) >= walkingAnimation.count {
      self.animationStep = 0
    }
  }
}
