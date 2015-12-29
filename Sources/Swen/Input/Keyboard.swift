//
//   Keyboard.swift created on 29/12/15
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

class Keyboard {
  static func getKeyboardFocus() -> Window? {
    let windowPtr = SDL_GetKeyboardFocus()

    return try? Window(fromHandle: windowPtr)
  }

  static func getModState() -> KeyMod {
    let modState = SDL_GetModState()

    return KeyMod(rawValue: modState.rawValue)
  }

  static func startTextInput() {
    SDL_StartTextInput()
  }

  static func isTextInputActive() -> Bool {
    return SDL_IsTextInputActive() == SDL_TRUE
  }

  static func stopTextInput() {
    SDL_StopTextInput()
  }
}
