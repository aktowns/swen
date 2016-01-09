//
//   GameBase.swift created on 29/12/15
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

import Glibc

public protocol GameBaseDelegate: GameLoop {
  init(withWindow: Window, pipeline: ContentPipeline, andGame: Game)
}

public struct Game {
  public let fps: Float
  public let frame: Int
  public let keyEvents: [KeyboardEvent]
  public let settings: GameSettings
  public let space: PhySpace
}

public class GameBase<GameDelegate:GameBaseDelegate> {
  public let pipeline: ContentPipeline
  public let window: Window
  public let delegate: GameDelegate
  public let fpsTimer: Timer
  public let space: PhySpace
  public let settings: GameSettings

  public init(withTitle title: String,
              size: Size,
              settings: GameSettings,
              andDelegate delegate: GameDelegate.Type) throws {
    try SDL.initSDL()

    self.window = try Window(withTitle: title, andSize: size)
    self.pipeline = ContentPipeline(withRenderer: self.window.renderer)
    self.fpsTimer = Timer()

    // Physics setup
    self.space = PhySpace()
    space.iterations = settings.physics.iterations
    space.gravity = settings.physics.gravity

    self.settings = settings

    let initialGame = Game(fps: 0, frame: 0, keyEvents: [], settings: settings, space: space)
    self.delegate = delegate.init(withWindow: window, pipeline: pipeline, andGame: initialGame)
  }

  public func start() {
    fpsTimer.start()
    var countedFrames: Int = 0
    var keyEvents: [KeyboardEvent] = []

    var events: [BaseEvent] = []
    var running = true

    while running {
      let averageFrames = Float(countedFrames) / (Float(fpsTimer.ticks()) / 1000.0)

      SDLEvent.poll {
        event in
        switch event {
        case is QuitEvent: running = false
        case let kbd as KeyboardEvent: keyEvents.append(kbd)
        default: events.append(event)
        }
      }

      let game = Game(fps: averageFrames, frame: countedFrames, keyEvents: keyEvents,
          settings: settings, space: space)

      window.renderer.drawColour = settings.backgroundColour

      window.renderer.clear()
      delegate.draw(game)
      delegate.update(game)
      window.renderer.present()

      space.step(settings.physics.timestep)

      countedFrames += 1
      keyEvents = []
    }
    fpsTimer.stop()
    self.close()
  }

  public func close() -> Void {
    SDL.quitSDL()
    exit(-1)
  }
}
