import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_JOYHATMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 hat;          /**< The joystick hat index */
// Uint8 value;        /**< The hat position value.
//                          *   \sa ::SDL_HAT_LEFTUP ::SDL_HAT_UP ::SDL_HAT_RIGHTUP
//                          *   \sa ::SDL_HAT_LEFT ::SDL_HAT_CENTERED ::SDL_HAT_RIGHT
//                          *   \sa ::SDL_HAT_LEFTDOWN ::SDL_HAT_DOWN ::SDL_HAT_RIGHTDOWN
//                          *
//                          *   Note that zero means the POV is centered.
//                          */
// Uint8 padding1;
// Uint8 padding2;

public class JoyHatEvent : CommonEvent {
  private var jhatMem: SDL_JoyHatEvent { return self.handle.memory.jhat }

  public var which: SDL_JoystickID { return jhatMem.which }
  public var hat: UInt8 { return jhatMem.hat }
  public var value: UInt8 { return jhatMem.value }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "hat:\(hat), value:\(value))"
  }
}