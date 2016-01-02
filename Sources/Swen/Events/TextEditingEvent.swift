//
//   TextEditingEvent.swift created on 27/12/15
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

// Uint32 type;                                /**< ::SDL_TEXTEDITING */
// Uint32 timestamp;
// Uint32 windowID;                            /**< The window with keyboard focus, if any */
// char text[SDL_TEXTEDITINGEVENT_TEXT_SIZE];  /**< The editing text */
// Sint32 start;                               /**< The start cursor of selected editing text */
// Sint32 length;                              /**< The length of selected editing text */

public class TextEditingEvent: CommonEvent {
  private var editEvent: SDL_TextEditingEvent {
    return self.handle.edit
  }

  public var windowId: UInt32 {
    return editEvent.windowID
  }
  public var text: String? {
    // for some reason fixed width arrays are converted to tuples..
    let mirror: Array<Int8> = Mirror(reflecting: editEvent.text).children.map {
      $0.value as! Int8
    }
    return String.fromCString(UnsafePointer(mirror))
  }
  public var start: Int32 {
    return editEvent.start
  }
  public var length: Int32 {
    return editEvent.length
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), " +
        "windowId:\(windowId), text:\(text), start:\(start), length:\(length))"
  }
}
