//
//   SDLExtensionCore.swift created on 28/12/15
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

import CSDL

public class SDLExtensionCore: SDLExtension {
  let subsystems = [
      "Timer": SDL_INIT_TIMER,
      "Audio": SDL_INIT_AUDIO,
      "Video": SDL_INIT_VIDEO,
      "Joystick": SDL_INIT_JOYSTICK,
      "Haptic": SDL_INIT_HAPTIC,
      "Game Controller": SDL_INIT_GAMECONTROLLER,
      "Events": SDL_INIT_EVENTS
  ]

  let flags: UInt32

  init() {
    self.flags = 0
  }

  init(flags: UInt32?) {
    self.flags = flags ?? 0
  }

  public func prepare() throws {
    if SDL_Init(flags) < 0 {
      throw SDLError.InitialisationError(message: "SDL_Init: \(SDL.getErrorMessage())")
    }

    print("** Initializing subsystems")
    for (name, subsystem) in self.subsystems {
      if SDL_InitSubSystem(UInt32(subsystem)) < 0 {
        print("Failed to load subsystem: \(name)")
      } else {
        print("Loaded subsystem: \(name)")
      }
    }
  }

  public func quit() {
    SDL_Quit()
  }
}
