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

public class Player : GameLoop {
  private let pipeline: ContentPipeline

  var player: Texture

  public init(pipeline: ContentPipeline) throws {
    self.pipeline = pipeline

    let playerStandingFile: ImageFile = pipeline.get(fromPath: "assets/sprites/player/alienBlue_stand.png")!
    self.player = try playerStandingFile.asTexture()
  }

  public func draw() {
    player.render(atPoint: Point(x: 120, y: 390))
  }

  public func loop() {

  }
}