//
//   ControllerButtonEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_CONTROLLERBUTTONDOWN or ::SDL_CONTROLLERBUTTONUP */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 button;       /**< The controller button (SDL_GameControllerButton) */
// Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
// Uint8 padding1;
// Uint8 padding2;

public class ControllerButtonEvent : CommonEvent {
  private var cbuttonEvent: SDL_ControllerButtonEvent { return self.handle.cbutton }

  public var which: SDL_JoystickID { return cbuttonEvent.which }
  public var button: UInt8 { return cbuttonEvent.button }
  public var state: UInt8 { return cbuttonEvent.state }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "button:\(button), state:\(state))"
  }
}