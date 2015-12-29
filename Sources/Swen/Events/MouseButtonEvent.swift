//
//   MouseButtonEvent.swift created on 27/12/15
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
  private var buttonEvent: SDL_MouseButtonEvent { return self.handle.button }

  public var windowId: UInt32 { return buttonEvent.windowID }
  public var which: UInt32 { return buttonEvent.which }
  public var button: UInt8 { return buttonEvent.button }
  public var state: UInt8 { return buttonEvent.state }
  public var clicks: UInt8 { return buttonEvent.clicks }
  public var position: Point<Int32> { return Point(x: buttonEvent.x, y: buttonEvent.y) }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), windowId:\(windowId), " +
        "which:\(which), button:\(button), state:\(state), clicks:\(clicks), position:\(position))"
  }
}