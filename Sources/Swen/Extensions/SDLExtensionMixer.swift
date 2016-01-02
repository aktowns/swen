//
//   SDLExtensionMixer.swift created on 28/12/15
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

public struct MixerInitFlags: OptionSetType {
  public let rawValue: Int32

  public init(rawValue: Int32) {
    self.rawValue = rawValue
  }

  public init(rawValue: UInt32) {
    self.rawValue = Int32(rawValue)
  }

  static let FLAC = MixerInitFlags(rawValue: MIX_INIT_FLAC.rawValue)
  static let MOD = MixerInitFlags(rawValue: MIX_INIT_MOD.rawValue)
  static let MODPLUG = MixerInitFlags(rawValue: MIX_INIT_MODPLUG.rawValue)
  static let MP3 = MixerInitFlags(rawValue: MIX_INIT_MP3.rawValue)
  static let OGG = MixerInitFlags(rawValue: MIX_INIT_OGG.rawValue)
  static let FLUIDSYNTH = MixerInitFlags(rawValue: MIX_INIT_FLUIDSYNTH.rawValue)
}

public class SDLExtensionMixer: SDLExtension {
  let flags: MixerInitFlags

  let defaultFlags: MixerInitFlags = [MixerInitFlags.FLAC,
                                      MixerInitFlags.MOD,
                                      MixerInitFlags.MODPLUG,
                                      MixerInitFlags.MP3,
                                      MixerInitFlags.OGG,
                                      MixerInitFlags.FLUIDSYNTH]

  init() {
    self.flags = defaultFlags
  }

  init(flags: MixerInitFlags) {
    self.flags = flags
  }

  public func prepare() throws {
    let initialised = MixerInitFlags(rawValue: Mix_Init(flags.rawValue))
    let failedToLoad = flags.subtract(initialised)

    if failedToLoad.contains(MixerInitFlags.FLAC) {
      print("Warning: Failed to load FLAC audio support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(MixerInitFlags.MOD) {
      print("Warning: Failed to load MOD audio support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(MixerInitFlags.MODPLUG) {
      print("Warning: Failed to load MODPLUG audio support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(MixerInitFlags.MP3) {
      print("Warning: Failed to load MP3 audio support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(MixerInitFlags.OGG) {
      print("Warning: Failed to load OGG audio support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(MixerInitFlags.FLUIDSYNTH) {
      print("Warning: Failed to load FLUIDSYNTH audio support: \(SDL.getErrorMessage())")
    }

    if Mix_OpenAudio(44100, UInt16(MIX_DEFAULT_FORMAT), 2, 2048) < 0 {
      throw SDLError.MixerOpenError(message: SDL.getErrorMessage())
    }
  }

  public func quit() {
    Mix_Quit()
  }
}
