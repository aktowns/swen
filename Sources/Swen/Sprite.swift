//
//   Sprite.swift created on 9/01/16
//   Swen project
//
//   Copyright 2016 Ashley Towns <code@ashleytowns.id.au>
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

import Signals

public protocol PhysicsBody {
  var position: Vector { get set }
  var velocity: Vector { get set }
  var size: Size { get set }
  var mass: Double { get set }
  var elasticity: Double { get set }
  var friction: Double { get set }
  var moment: Double { get set }
  var radius: Double { get set }
}

extension PhysicsBody {
  public var bodyRect: Rect {
    return Rect(x: position.x, y: position.y, sizeX: size.sizeX, sizeY: size.sizeY)
  }
}

public protocol PhysicsUpdatable {
  func willUpdatePosition(position: Vector)

  func willUpdateVelocity(velocity: Vector)
}

public protocol CustomVelocityPhysics {
  func velocityUpdate(body: PhyBody, gravity: Vector, damping: Double, dt: Double)
}

public protocol CustomPositionPhysics {
  func positionUpdate(body: PhyBody, dt: Double)
}

public class Sprite: PhysicsUpdatable, PhysicsBody {
  public let pipeline: ContentPipeline

  let onPositionChanged = Signal<Vector>()
  let onVelocityChanged = Signal<Vector>()
  let onSizeChanged = Signal<Size>()
  let onMassChanged = Signal<Double>()
  let onElasticityChanged = Signal<Double>()
  let onFrictionChanged = Signal<Double>()

  public var position: Vector {
    didSet { onPositionChanged => position }
  }

  public var velocity: Vector {
    didSet { onVelocityChanged => velocity }
  }

  public var size: Size {
    didSet { onSizeChanged => size }
  }

  public var mass: Double {
    didSet { onMassChanged => mass }
  }

  public var elasticity: Double {
    didSet { onElasticityChanged => elasticity }
  }

  public var friction: Double {
    didSet { onFrictionChanged => friction }
  }

  public var moment = Double.infinity
  public var radius = 10.0

  public var spriteMainBody: PhyBody?
  public var spriteMainShape: PhyShape?

  public init(pipeline: ContentPipeline) throws {
    self.pipeline = pipeline
    self.position = Vector.zero
    self.velocity = Vector.zero
    self.size = Size.zero
    self.mass = 1.0
    self.elasticity = 0.0
    self.friction = 0.0

    self.spriteMainBody = Optional.None
    self.spriteMainShape = Optional.None

    setup()
  }

  public func setup() {

  }

  public func willUpdatePosition(position: Vector) {
    self.position = position
  }

  public func willUpdateVelocity(velocity: Vector) {
    self.velocity = velocity
  }

  public func registerInSpace(space: PhySpace, withTag tag: String) {
    self.spriteMainBody = PhyBody(mass: self.mass, moment: self.moment)
    self.spriteMainShape = PhyShape(boxShapeFrom: spriteMainBody!, box: PhyBoundingBox(size: self.size),
        radius: self.radius)

    let body = space.addBody(self.spriteMainBody!)
    body.position = self.position

    body.onPositionChanged.listen(self) {
      (newPos) in
      if self.position != newPos {
        self.willUpdatePosition(newPos)
      }
    }
    body.onVelocityChanged.listen(self) {
      (newVel) in
      if self.velocity != newVel {
        self.willUpdateVelocity(newVel)
      }
    }

    self.onPositionChanged.listen(body) {
      (newPos) in
      body.position = newPos
    }

    self.onVelocityChanged.listen(body) {
      (newVel) in
      body.velocity = newVel
    }

    self.onMassChanged.listen(body) {
      (newMass) in
      body.mass = newMass
    }

    switch self {
    case let spr as CustomVelocityPhysics: body.setVelocityUpdateFunc(spr.velocityUpdate)
    case let spr as CustomPositionPhysics: body.setPositionUpdateFunc(spr.positionUpdate)
    default: Void()
    }

    let shape = space.addShape(self.spriteMainShape!)

    shape.elasticity = self.elasticity
    shape.friction = self.friction
    shape.collisionType = 1
    shape.tag = tag

    self.onElasticityChanged.listen(shape) {
      (newElas) in
      shape.elasticity = newElas
    }

    self.onFrictionChanged.listen(shape) {
      (newFric) in
      shape.friction = newFric
    }
  }
}
