//
//   KeyboardEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_KEYDOWN or ::SDL_KEYUP */
// Uint32 timestamp;
// Uint32 windowID;    /**< The window with keyboard focus, if any */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 repeat;       /**< Non-zero if this is a key repeat */
// Uint8 padding2;
// Uint8 padding3;
// SDL_Keysym keysym;  /**< The key that was pressed or released */

// ** SDL_Keysym
// SDL_Scancode scancode;      /**< SDL physical key code - see ::SDL_Scancode for details */
// SDL_Keycode sym;            /**< SDL virtual key code - see ::SDL_Keycode for details */
// Uint16 mod;                 /**< current key modifiers */
// Uint32 unused;

public enum KeyState: Uint8 {
  case Released = 0
  case Pressed = 1
}

public class KeyboardEvent: CommonEvent {
  private var keyEvent: SDL_KeyboardEvent {
    return self.handle.key
  }

  public var windowId: UInt32 {
    return keyEvent.windowID
  }
  public var state: KeyState {
    return KeyState(rawValue: keyEvent.state)!
  }
  public var keyRepeat: Bool {
    return keyEvent.`repeat` != 0
  }

  public var keyMod: KeyMod {
    return KeyMod(rawValue: keyEvent.keysym.mod)
  }
  public var scanCode: ScanCode {
    return ScanCode(rawValue: keyEvent.keysym.scancode.rawValue)!
  }
  public var keyCode: KeyCode? {
    return KeyCode(rawValue: keyEvent.keysym.sym)
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), windowId:\(windowId) " +
        "state:\(state), keyRepeat:\(keyRepeat), keyMod:\(keyMod), scanCode:\(scanCode), keyCode:\(keyCode))"
  }
}
