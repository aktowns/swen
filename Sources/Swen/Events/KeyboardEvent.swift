import CSDL

public enum KeyState: Uint8 {
  case Released = 0
  case Pressed = 1
}

public struct KeyMod : OptionSetType {
  public let rawValue: UInt16

  public init(rawValue: UInt16) {
    self.rawValue = rawValue
  }

  public init(rawValue: UInt32) {
    self.rawValue = UInt16(rawValue)
  }

  static let None     = KeyMod(rawValue: KMOD_NONE.rawValue)
  static let LShift   = KeyMod(rawValue: KMOD_LSHIFT.rawValue)
  static let RShift   = KeyMod(rawValue: KMOD_RSHIFT.rawValue)
  static let LCtrl    = KeyMod(rawValue: KMOD_LCTRL.rawValue)
  static let RCtrl    = KeyMod(rawValue: KMOD_RCTRL.rawValue)
  static let LAlt     = KeyMod(rawValue: KMOD_LALT.rawValue)
  static let RAlt     = KeyMod(rawValue: KMOD_RALT.rawValue)
  static let LGUI     = KeyMod(rawValue: KMOD_LGUI.rawValue)
  static let RGUI     = KeyMod(rawValue: KMOD_RGUI.rawValue)
  static let NUM      = KeyMod(rawValue: KMOD_NUM.rawValue)
  static let CAPS     = KeyMod(rawValue: KMOD_CAPS.rawValue)
  static let MODE     = KeyMod(rawValue: KMOD_MODE.rawValue)
  static let RESERVED = KeyMod(rawValue: KMOD_RESERVED.rawValue)

  public var Ctrl: Bool {
    return self.contains(KeyMod.LCtrl) || self.contains(KeyMod.RCtrl)
  }
  public var Shift: Bool {
    return self.contains(KeyMod.LShift) || self.contains(KeyMod.RShift)
  }
  public var Alt: Bool {
    return self.contains(KeyMod.LAlt) || self.contains(KeyMod.RAlt)
  }
  public var GUI: Bool {
    return self.contains(KeyMod.LGUI) || self.contains(KeyMod.RGUI)
  }
}

struct KeyCode {

}

public struct KeyboardSymbol {
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

//** SDL_Keysym
//SDL_Scancode scancode;      /**< SDL physical key code - see ::SDL_Scancode for details */
//SDL_Keycode sym;            /**< SDL virtual key code - see ::SDL_Keycode for details */
//Uint16 mod;                 /**< current key modifiers */
//Uint32 unused;

public class KeyboardEvent : CommonEvent {
  private var keyEvent: SDL_KeyboardEvent { return self.handle.key }

  public var windowId: UInt32 { return keyEvent.windowID }
  public var state: UInt8 { return keyEvent.state }
  public var keyRepeat: Bool { return keyEvent.`repeat` != 0 }
  public var keySym: SDL_Keysym { return keyEvent.keysym }
  public var keyMod: KeyMod { return KeyMod(rawValue: keyEvent.keysym.mod) }
  public var keyScanCode: ScanCode { return ScanCode(rawValue: keyEvent.keysym.scancode.rawValue)! }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), windowId:\(windowId) " +
        "state:\(state), keyRepeat:\(keyRepeat), keySym:\(keySym))"
  }
}
