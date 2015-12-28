import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_USEREVENT through ::SDL_LASTEVENT-1 */
// Uint32 timestamp;
// Uint32 windowID;    /**< The associated window if any */
// Sint32 code;        /**< User defined event code */
// void *data1;        /**< User defined data pointer */
// void *data2;        /**< User defined data pointer */

public class UserEvent : CommonEvent {
  private var userMem: SDL_UserEvent { return self.handle.memory.user }

  public var windowId: UInt32 { return userMem.windowID }
  public var code: Int32 { return userMem.code }
  public var data1: UnsafeMutablePointer<Void> { return userMem.data1 }
  public var data2: UnsafeMutablePointer<Void> { return userMem.data2 }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "code:\(code), data1:\(data1), data2:\(data2))"
  }
}
