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

public class Sprite: PhysicsUpdatable, PhysicsBody {
  public let pipeline: ContentPipeline

  public var position: Vector = Vector.zero
  public var velocity: Vector = Vector.zero
  public var size: Size = Size.zero
  public var mass = 20.0
  public var elasticity = 0.0
  public var friction = 0.7
  public var moment = Double.infinity
  public var radius = 20.0

  public init(pipeline: ContentPipeline) throws {
    self.pipeline = pipeline

    setup()
  }

  public func setup() {

  }

  public func willUpdatePosition(position: Vector) -> Bool {
    self.position = position

    return true
  }

  public func willUpdateVelocity(velocity: Vector) -> Bool {
    self.velocity = velocity

    return true
  }
}
