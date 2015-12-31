//
//   JoyBallEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_JOYBALLMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 ball;         /**< The joystick trackball index */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint16 xrel;        /**< The relative motion in the X direction */
// Sint16 yrel;        /**< The relative motion in the Y direction */

public class JoyBallEvent : CommonEvent {
  private var jballEvent: SDL_JoyBallEvent { return self.handle.jball }

  public var which: SDL_JoystickID { return jballEvent.which }
  public var ball: UInt8 { return jballEvent.ball }
  public var motion: Vector { return Vector(x: jballEvent.xrel, y: jballEvent.yrel) }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "ball:\(ball), motion:\(motion))"
  }
}