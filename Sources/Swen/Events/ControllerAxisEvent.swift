//
//   ControllerAxisEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_CONTROLLERAXISMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 axis;         /**< The controller axis (SDL_GameControllerAxis) */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint16 value;       /**< The axis value (range: -32768 to 32767) */
// Uint16 padding4;

public class ControllerAxisEvent: CommonEvent {
  private var caxisEvent: SDL_ControllerAxisEvent {
    return self.handle.caxis
  }

  public var which: SDL_JoystickID {
    return caxisEvent.which
  }
  public var axis: UInt8 {
    return caxisEvent.axis
  }
  public var value: Int16 {
    return caxisEvent.value
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "axis:\(axis), value:\(value))"
  }
}
