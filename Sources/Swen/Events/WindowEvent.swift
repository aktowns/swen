import CSDL

// Uint32 type;        /**< ::SDL_WINDOWEVENT */
// Uint32 timestamp;
// Uint32 windowID;    /**< The associated window */
// Uint8 event;        /**< ::SDL_WindowEventID */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint32 data1;       /**< event dependent data */
// Sint32 data2;       /**< event dependent data */

public class WindowEvent : CommonEvent {
  private var windowEvent: SDL_WindowEvent { return self.handle.window }

  public var windowId: UInt32 { return windowEvent.windowID }
  public var event: UInt8 { return windowEvent.event }
  public var data1: Int32 { return windowEvent.data1 }
  public var data2: Int32 { return windowEvent.data2 }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "event:\(event), data1:\(data1), data2:\(data2))"
  }
}