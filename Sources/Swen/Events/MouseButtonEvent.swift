import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_MOUSEBUTTONDOWN or ::SDL_MOUSEBUTTONUP */
// Uint32 timestamp;
// Uint32 windowID;    /**< The window with mouse focus, if any */
// Uint32 which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
// Uint8 button;       /**< The mouse button index */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 clicks;       /**< 1 for single-click, 2 for double-click, etc. */
// Uint8 padding1;
// Sint32 x;           /**< X coordinate, relative to window */
// Sint32 y;           /**< Y coordinate, relative to window */

public class MouseButtonEvent : CommonEvent {
  private var buttonMem: SDL_MouseButtonEvent { return self.handle.memory.button }

  public var windowId: UInt32 { return buttonMem.windowID }
  public var which: UInt32 { return buttonMem.which }
  public var button: UInt8 { return buttonMem.button }
  public var state: UInt8 { return buttonMem.state }
  public var clicks: UInt8 { return buttonMem.clicks }
  public var position: Point<Int32> { return Point(x: buttonMem.x, y: buttonMem.y) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), button:\(button), state:\(state), clicks:\(clicks), position:\(position))"
  }
}