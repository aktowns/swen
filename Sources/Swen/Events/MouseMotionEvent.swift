//
//   MouseMotionEvent.swift created on 27/12/15
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
  private var motionEvent: SDL_MouseMotionEvent { return self.handle.motion }

  public var windowId: UInt32 { return motionEvent.windowID }
  public var which: UInt32 { return motionEvent.which }
  public var state: UInt32 { return motionEvent.state }
  public var position: Vector { return Vector(x: motionEvent.x, y: motionEvent.y) }
  public var relativePosition: Vector { return Vector(x: motionEvent.xrel, y: motionEvent.yrel) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), state:\(state), position:\(position), relativePosition:\(relativePosition))"
  }
}
