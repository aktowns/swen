//
//   UserEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_USEREVENT through ::SDL_LASTEVENT-1 */
// Uint32 timestamp;
// Uint32 windowID;    /**< The associated window if any */
// Sint32 code;        /**< User defined event code */
// void *data1;        /**< User defined data pointer */
// void *data2;        /**< User defined data pointer */

public class UserEvent : CommonEvent {
  private var userEvent: SDL_UserEvent { return self.handle.user }

  public var windowId: UInt32 { return userEvent.windowID }
  public var code: Int32 { return userEvent.code }
  public var data1: UnsafeMutablePointer<Void> { return userEvent.data1 }
  public var data2: UnsafeMutablePointer<Void> { return userEvent.data2 }

  override public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), windowId:\(windowId), " +
        "code:\(code), data1:\(data1), data2:\(data2))"
  }
}
