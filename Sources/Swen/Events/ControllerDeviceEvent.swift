//
//   ControllerDeviceEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_CONTROLLERDEVICEADDED, ::SDL_CONTROLLERDEVICEREMOVED, or
//                          ::SDL_CONTROLLERDEVICEREMAPPED */
// Uint32 timestamp;
// Sint32 which;       /**< The joystick device index for the ADDED event, instance id for
//                          the REMOVED or REMAPPED event */

public class ControllerDeviceEvent: CommonEvent {
  private var cdeviceEvent: SDL_ControllerDeviceEvent {
    return self.handle.cdevice
  }

  public var which: Int32 {
    return cdeviceEvent.which
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which))"
  }
}
