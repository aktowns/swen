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
