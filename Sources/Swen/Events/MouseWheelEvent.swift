import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_MOUSEWHEEL */
// Uint32 timestamp;
// Uint32 windowID;    /**< The window with mouse focus, if any */
// Uint32 which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
// Sint32 x;           /**< The amount scrolled horizontally, positive to the right and negative to the left */
// Sint32 y;           /**< The amount scrolled vertically, positive away from the user and negative toward the user */
// Uint32 direction;   /**< Set to one of the SDL_MOUSEWHEEL_* defines. When FLIPPED the
//                          values in X and Y will be opposite. Multiply by -1 to change them back */

public class MouseWheelEvent : CommonEvent {
  private var wheelMem: SDL_MouseWheelEvent { return self.handle.memory.wheel }

  public var windowId: UInt32 { return wheelMem.windowID }
  public var which: UInt32 { return wheelMem.which }
  public var direction: UInt32 { return wheelMem.direction }
  public var position: Point<Int32> { return Point(x: wheelMem.x, y: wheelMem.y) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), position:\(position), direction:\(direction))"
  }
}