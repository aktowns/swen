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

public class Player: Sprite, GameLoop, CustomVelocityPhysics {
  let standingAnimation = ["alienBlue_stand"]
  let walkingAnimation = ["alienBlue_walk1", "alienBlue_stand", "alienBlue_walk2"]

  var player: Texture?
  var playerMap: [String: Rect] = [:]
  var animationStep: Int = 0
  var playerVelocity: Int = 20
  var direction: Vector = Vector.zero

  var grounded: Bool = false
  var lastJumpState: Bool = false
  var remainingBoost: Double = 0.0

  let GRAVITY = 2000.0
  let JUMP_HEIGHT = 50.0
  let JUMP_BOOST_HEIGHT = 55.0

  public override func setup() {
    let playerSpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_players.xml")!

    self.player = try? playerSpriteMap.imageFile.asTexture()
    self.playerMap = playerSpriteMap.mapping

    let anim = playerMap[currentAnimation[animationStep]]!

    self.size = anim.size
    self.position = Vector(x: 300, y: 300)
  }

  public func draw(game: Game) {
    let animation = playerMap[currentAnimation[self.animationStep / 12]]
    player!.render(atPoint: position, clip: animation!)
  }

  public func update(game: Game) {
    let jumpState: Bool = direction.y > 0.0

    if jumpState && !lastJumpState && grounded {
      print("Jumping!")
      var jump_v = Math.sqrt(2.0 * JUMP_HEIGHT * GRAVITY)
      spriteMainBody!.velocity += Vector(x: 0.0, y: jump_v)

      remainingBoost = JUMP_BOOST_HEIGHT / jump_v
    }

    remainingBoost -= game.settings.physics.timestep
    lastJumpState = jumpState

    self.animationStep += 1
    if (self.animationStep / 12) >= currentAnimation.count {
      self.animationStep = 0
    }
  }

  public var currentAnimation: [String] {
    get {
      if self.direction.x != 0 {
        return walkingAnimation
      } else {
        return standingAnimation
      }
    }
  }

  public func velocityUpdate(body: PhyBody, gravity: Vector, damping: Double, dt: Double) {
    let PLAYER_VELOCITY = 500.0

    let PLAYER_GROUND_ACCEL_TIME = 0.1
    let PLAYER_GROUND_ACCEL = (PLAYER_VELOCITY / PLAYER_GROUND_ACCEL_TIME)

    let PLAYER_AIR_ACCEL_TIME = 0.25
    let PLAYER_AIR_ACCEL = (PLAYER_VELOCITY / PLAYER_AIR_ACCEL_TIME)

    let FALL_VELOCITY = 900.0

    let jumpState: Bool = direction.y > 0.0

    var groundNormal: Vector = Vector.zero;

    body.eachArbiter() {
      (arbiter: PhyArbiter) in
      print(arbiter)
      let n: Vector = arbiter.normal.negated
      if n.y > groundNormal.y {
        groundNormal = n
      }
    }

    grounded = groundNormal.y > 0.0

    if groundNormal.y < 0.0 {
      remainingBoost = 0.0
    }

    let boost = jumpState && remainingBoost > 0.0
    let g = boost ? Vector.zero : gravity
    body.updateVelocity(g, damping: damping, dt: dt)

    let targetVx = PLAYER_VELOCITY * direction.x

    let surfaceV = Vector(x: -targetVx, y: 0.0)
    spriteMainShape!.surfaceVelocity = surfaceV
    spriteMainShape!.friction = grounded ? PLAYER_GROUND_ACCEL / GRAVITY : 0.0

    if !grounded {
      body.velocity.x = Math.lerp(body.velocity.x, targetVx, PLAYER_AIR_ACCEL * dt)
    }

    body.velocity.y = Math.clamp(body.velocity.y, minValue: -FALL_VELOCITY, maxValue: Double.infinity)
  }
}
