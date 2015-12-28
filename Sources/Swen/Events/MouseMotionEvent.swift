import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_MOUSEMOTION */
// Uint32 timestamp;
// Uint32 windowID;    /**< The window with mouse focus, if any */
// Uint32 which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
// Uint32 state;       /**< The current button state */
// Sint32 x;           /**< X coordinate, relative to window */
// Sint32 y;           /**< Y coordinate, relative to window */
// Sint32 xrel;        /**< The relative motion in the X direction */
// Sint32 yrel;        /**< The relative motion in the Y direction */

public class MouseMotionEvent : CommonEvent {
  private var motionMem: SDL_MouseMotionEvent { return self.handle.memory.motion }

  public var windowId: UInt32 { return motionMem.windowID }
  public var which: UInt32 { return motionMem.which }
  public var state: UInt32 { return motionMem.state }
  public var position: Point<Int32> { return Point(x: motionMem.x, y: motionMem.y) }
  public var relativePosition: Point<Int32> { return Point(x: motionMem.xrel, y: motionMem.yrel) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), state:\(state), position:\(position), relativePosition:\(relativePosition))"
  }
}
