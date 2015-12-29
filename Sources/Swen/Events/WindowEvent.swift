//
//   WindowEvent.swift created on 27/12/15
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