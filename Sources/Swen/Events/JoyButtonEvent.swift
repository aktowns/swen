import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_JOYBUTTONDOWN or ::SDL_JOYBUTTONUP */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 button;       /**< The joystick button index */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 padding1;
// Uint8 padding2;

public class JoyButtonEvent : CommonEvent {
  private var jbuttonMem: SDL_JoyButtonEvent { return self.handle.memory.jbutton }

  public var which: SDL_JoystickID { return jbuttonMem.which }
  public var button: UInt8 { return jbuttonMem.button }
  public var state: UInt8 { return jbuttonMem.state }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "button:\(button), state:\(state))"
  }
}