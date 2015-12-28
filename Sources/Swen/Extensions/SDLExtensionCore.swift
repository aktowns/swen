import Foundation
import CSDL

public class SDLExtensionCore : SDLExtension {
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
  }

  public func start() throws {
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