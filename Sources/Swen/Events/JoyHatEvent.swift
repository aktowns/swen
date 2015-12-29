//
//   JoyHatEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_JOYHATMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 hat;          /**< The joystick hat index */
// Uint8 value;        /**< The hat position value.
//                          *   \sa ::SDL_HAT_LEFTUP ::SDL_HAT_UP ::SDL_HAT_RIGHTUP
//                          *   \sa ::SDL_HAT_LEFT ::SDL_HAT_CENTERED ::SDL_HAT_RIGHT
//                          *   \sa ::SDL_HAT_LEFTDOWN ::SDL_HAT_DOWN ::SDL_HAT_RIGHTDOWN
//                          *
//                          *   Note that zero means the POV is centered.
//                          */
// Uint8 padding1;
// Uint8 padding2;

public class JoyHatEvent : CommonEvent {
  private var jhatEvent: SDL_JoyHatEvent { return self.handle.jhat }

  public var which: SDL_JoystickID { return jhatEvent.which }
  public var hat: UInt8 { return jhatEvent.hat }
  public var value: UInt8 { return jhatEvent.value }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "hat:\(hat), value:\(value))"
  }
}