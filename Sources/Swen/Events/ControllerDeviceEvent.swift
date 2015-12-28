import CSDL

// Uint32 type;        /**< ::SDL_CONTROLLERDEVICEADDED, ::SDL_CONTROLLERDEVICEREMOVED, or
//                          ::SDL_CONTROLLERDEVICEREMAPPED */
// Uint32 timestamp;
// Sint32 which;       /**< The joystick device index for the ADDED event, instance id for
//                          the REMOVED or REMAPPED event */

public class ControllerDeviceEvent : CommonEvent {
  private var cdeviceEvent: SDL_ControllerDeviceEvent { return self.handle.cdevice }

  public var which: Int32 { return cdeviceEvent.which }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which))"
  }
}