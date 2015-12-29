//
//   BaseEvent.swift created on 27/12/15
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

public class BaseEvent : CustomStringConvertible {
  let handle: SDL_Event

  init(handle: SDL_Event) {
    self.handle = handle
  }

  var type: SDL_EventType {
    return SDL_EventType(handle.type)
  }

  public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type))"
  }
}
