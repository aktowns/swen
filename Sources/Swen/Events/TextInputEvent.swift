//
//   TextInputEvent.swift created on 27/12/15
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

// Uint32 type;                              /**< ::SDL_TEXTINPUT */
// Uint32 timestamp;
// Uint32 windowID;                          /**< The window with keyboard focus, if any */
// char text[SDL_TEXTINPUTEVENT_TEXT_SIZE];  /**< The input text */

public class TextInputEvent: CommonEvent {
  private var textEvent: SDL_TextInputEvent {
    return self.handle.text
  }

  public var windowId: UInt32 {
    return textEvent.windowID
  }
  public var text: String? {
    // for some reason fixed width arrays are converted to tuples..
    let mirror: Array<Int8> = Mirror(reflecting: textEvent.text).children.map {
      $0.value as! Int8
    }
    return String.fromCString(UnsafePointer(mirror))
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), " +
        "windowId:\(windowId), text:\(text))"
  }
}
