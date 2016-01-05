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

/*
    let body = space.addBody(PhyBody(mass: 20.0, moment: Double.infinity))
    body.position = player.position
    let shape = space.addShape(PhyShape(boxShapeFrom: body,
        box: PhyBoundingBox(l: -15.0, b: -27.5, r: 15.0, t: 27.5), radius: 10.0))
    shape.elasticity = 0.0
    shape.friction = 0.0
    shape.collisionType = 1
*/

public struct DefaultBodyPhysics {

}

public class Player: GameLoop, PhysicsBody {
  private let pipeline: ContentPipeline

  var player: Texture
  var playerMap: [String:Rect]
  let walkingAnimation = ["alienBlue_walk1", "alienBlue_stand", "alienBlue_walk2"]
  var animationStep: Int = 0
  var playerVelocity: Int = 20

  public var position: Vector = Vector(x: 320.0, y: 340.0)
  public var velocity: Vector = Vector.zero
  public var size: Size = Size.zero
  public var mass = 20.0
  public var elasticity = 0.0
  public var friction = 0.7
  public var moment = Double.infinity
  public var radius = 20.0

  public func setPosition(position: Vector) {
    self.position = position
  }

  public init(pipeline: ContentPipeline, space: PhySpace) throws {
    self.pipeline = pipeline

    let playerSpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_players.xml")!

    self.player = try playerSpriteMap.imageFile.asTexture()
    self.playerMap = playerSpriteMap.mapping

    let anim = playerMap[walkingAnimation[animationStep]]!
    self.size = anim.size
  }

  public func draw(game: Game) {
//    let animation: Rect<Int32>? = {
//      if velocity.y != 0 {
//        return playerMap["alienBlue_jump"]
//      } else {
//        return playerMap[walkingAnimation[self.animationStep]]
//      }
//    }()

    let animation = playerMap[walkingAnimation[self.animationStep / 8]]
    player.render(atPoint: position, clip: animation!)
  }

  public func update(game: Game) {
    // velocity.x = 0

//    for keyEvent in game.keyEvents {
//      switch keyEvent.scanCode {
//        case .ScanCodeRight: velocity.x += playerVelocity
//        case .ScanCodeLeft: velocity.x -= playerVelocity
//        case .ScanCodeSpace:
//          if velocity.y == 0 {
//            position.y -= 100
//            velocity.y += 100
//          }
//        default: Void()
//      }
//    }

//    position.x += velocity.x
    // position.y += velocity.y

//    if velocity.y > 0 {
//      velocity.y -= 1
//      position.y += 1
//    } else if velocity.y < 0 {
//      velocity.y += 1
//      position.y -= 1
//    }

    // if velocity.x != 0 {
    self.animationStep += 1
    if ((self.animationStep / 8) >= walkingAnimation.count) {
      self.animationStep = 0
    }
  }
  //}
}
