import CSDL

// Uint32 type;        /**< ::SDL_JOYAXISMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 axis;         /**< The joystick axis index */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint16 value;       /**< The axis value (range: -32768 to 32767) */
// Uint16 padding4;

public class JoyAxisEvent : CommonEvent {
  private var jaxisEvent: SDL_JoyAxisEvent { return self.handle.jaxis }

  public var which: SDL_JoystickID { return jaxisEvent.which }
  public var axis: UInt8 { return jaxisEvent.axis }
  public var value: Int16 { return jaxisEvent.value }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "axis:\(axis), value:\(value))"
  }
}