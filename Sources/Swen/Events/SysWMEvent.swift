import CSDL

// Uint32 type;        /**< ::SDL_SYSWMEVENT */
// Uint32 timestamp;
// SDL_SysWMmsg *msg;  /**< driver dependent data, defined in SDL_syswm.h */
//
// SDL_version version;
// SDL_SYSWM_TYPE subsystem;
// msg = struct {
//  XEvent event;
// } x11;

public class SysWMEvent : CommonEvent {
  private var syswmEvent: SDL_SysWMEvent { return self.handle.syswm }

  public var msg: UnsafeMutablePointer<SDL_SysWMmsg> { return syswmEvent.msg }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), msg:\(msg))"
  }
}