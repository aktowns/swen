//
//   GameSettings.swift created on 2/01/16
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

public struct GamePhysicSettings {
  public var gravity: Vector = Vector(x: 0.0, y: 500.0)
  public var iterations: Int32 = 10
  public var timestep: Double = 1.0 / 60.0
}

public struct GameSettings {
  public var physics: GamePhysicSettings = GamePhysicSettings()
  public var backgroundColour: Colour = Colour.black

  public init() {}
}
