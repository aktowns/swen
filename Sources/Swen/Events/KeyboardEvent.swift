import CSDL

public enum KeyState: Uint8 {
  case Released = 0
  case Pressed = 1
}

struct ScanCode {

}

struct KeyCode {

}

struct KeyboardSymbol {
  var scancode: SDL_Scancode
  var keycode: SDL_Keycode
  var mod: UInt16
}

// Uint32 type;        /**< ::SDL_KEYDOWN or ::SDL_KEYUP */
// Uint32 timestamp;
// Uint32 windowID;    /**< The window with keyboard focus, if any */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 repeat;       /**< Non-zero if this is a key repeat */
// Uint8 padding2;
// Uint8 padding3;
// SDL_Keysym keysym;  /**< The key that was pressed or released */

public class KeyboardEvent : CommonEvent {
  private var keyEvent: SDL_KeyboardEvent { return self.handle.key }

  public var windowId: UInt32 { return keyEvent.windowID }
  public var state: UInt8 { return keyEvent.state }
  public var keyRepeat: Bool { return keyEvent.`repeat` != 0 }
  public var keySym: SDL_Keysym { return keyEvent.keysym }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), windowId:\(windowId) " +
        "state:\(state), keyRepeat:\(keyRepeat), keySym:\(keySym))"
  }
}
