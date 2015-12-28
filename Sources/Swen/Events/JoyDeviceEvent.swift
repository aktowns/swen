import CSDL

// Uint32 type;        /**< ::SDL_JOYDEVICEADDED or ::SDL_JOYDEVICEREMOVED */
// Uint32 timestamp;
// Sint32 which;       /**< The joystick device index for the ADDED event, instance id for the REMOVED event */

public class JoyDeviceEvent : CommonEvent {
  private var jdeviceEvent: SDL_JoyDeviceEvent { return self.handle.jdevice }

  public var which: Int32 { return jdeviceEvent.which }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which))"
  }
}