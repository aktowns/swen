import CSDL

// Uint32 type;        /**< ::SDL_CONTROLLERAXISMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 axis;         /**< The controller axis (SDL_GameControllerAxis) */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint16 value;       /**< The axis value (range: -32768 to 32767) */
// Uint16 padding4;

public class ControllerAxisEvent : CommonEvent {
  private var caxisEvent: SDL_ControllerAxisEvent { return self.handle.caxis }

  public var which: SDL_JoystickID { return caxisEvent.which }
  public var axis: UInt8 { return caxisEvent.axis }
  public var value: Int16 { return caxisEvent.value }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "axis:\(axis), value:\(value))"
  }
}