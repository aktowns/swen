import CSDL

// Uint32 type;        /**< ::SDL_CONTROLLERBUTTONDOWN or ::SDL_CONTROLLERBUTTONUP */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 button;       /**< The controller button (SDL_GameControllerButton) */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 padding1;
// Uint8 padding2;

public class ControllerButtonEvent : CommonEvent {
  private var cbuttonEvent: SDL_ControllerButtonEvent { return self.handle.cbutton }

  public var which: SDL_JoystickID { return cbuttonEvent.which }
  public var button: UInt8 { return cbuttonEvent.button }
  public var state: UInt8 { return cbuttonEvent.state }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "button:\(button), state:\(state))"
  }
}