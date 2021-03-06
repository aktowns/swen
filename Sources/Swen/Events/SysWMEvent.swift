//
//   SysWMEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_SYSWMEVENT */
// Uint32 timestamp;
// SDL_SysWMmsg *msg;  /**< driver dependent data, defined in SDL_syswm.h */
//
// SDL_version version;
// SDL_SYSWM_TYPE subsystem;
// msg = struct {
//  XEvent event;
// } x11;

public class SysWMEvent: CommonEvent {
  private var syswmEvent: SDL_SysWMEvent {
    return self.handle.syswm
  }

  public var msg: UnsafeMutablePointer<SDL_SysWMmsg> {
    return syswmEvent.msg
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), msg:\(msg))"
  }
}
