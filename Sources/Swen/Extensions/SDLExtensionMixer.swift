import Foundation
import CSDL

public class SDLExtensionMixer : SDLExtension {
  let flags: Int32

  let defaultFlags: UInt32 = MIX_INIT_FLAC.rawValue
      | MIX_INIT_MOD.rawValue
      | MIX_INIT_MODPLUG.rawValue
      | MIX_INIT_MP3.rawValue
      | MIX_INIT_OGG.rawValue
      | MIX_INIT_FLUIDSYNTH.rawValue

  init() {
    self.flags = Int32(defaultFlags)
  }

  init(flags: UInt32) {
    self.flags = Int32(flags)
  }

  public func prepare() throws {
    if (Mix_Init(self.flags) & self.flags) == 0 {
      throw SDLError.InitialisationError(message: "Mix_Init: \(SDL.getErrorMessage())")
    }
  }

  public func start() throws {
    if Mix_OpenAudio(44100, UInt16(MIX_DEFAULT_FORMAT), 2, 2048 ) < 0 {
      throw SDLError.MixerOpenError(message: SDL.getErrorMessage())
    }
  }

  public func quit() {
    Mix_Quit()
  }
}