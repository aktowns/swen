import CSDL

// Uint32 type;        /**< ::SDL_JOYBUTTONDOWN or ::SDL_JOYBUTTONUP */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 button;       /**< The joystick button index */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 padding1;
// Uint8 padding2;

public class JoyButtonEvent : CommonEvent {
  private var jbuttonEvent: SDL_JoyButtonEvent { return self.handle.jbutton }

  public var which: SDL_JoystickID { return jbuttonEvent.which }
  public var button: UInt8 { return jbuttonEvent.button }
  public var state: UInt8 { return jbuttonEvent.state }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "button:\(button), state:\(state))"
  }
}