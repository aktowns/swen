//
//   MouseWheelEvent.swift created on 27/12/15
//   Swen project
//
//   Copyright 2015 Ashley Towns <code@ashleytowns.id.au>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

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
  private var wheelEvent: SDL_MouseWheelEvent { return self.handle.wheel }

  public var windowId: UInt32 { return wheelEvent.windowID }
  public var which: UInt32 { return wheelEvent.which }
  public var direction: UInt32 { return wheelEvent.direction }
  public var position: Vector { return Vector.fromInt32(x: wheelEvent.x, y: wheelEvent.y) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), position:\(position), direction:\(direction))"
  }
}