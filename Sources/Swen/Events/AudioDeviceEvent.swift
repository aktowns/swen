//
//   AudioDeviceEvent.swift created on 27/12/15
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

// Uint32 type;        /**< ::SDL_AUDIODEVICEADDED, or ::SDL_AUDIODEVICEREMOVED */
// Uint32 timestamp;
// Uint32 which;       /**< The audio device index for the ADDED event (valid until
//                          next SDL_GetNumAudioDevices() call), SDL_AudioDeviceID for the REMOVED event */
// Uint8 iscapture;    /**< zero if an output device, non-zero if a capture device. */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;

public class AudioDeviceEvent: CommonEvent {
  private var adeviceEvent: SDL_AudioDeviceEvent {
    return self.handle.adevice
  }

  public var which: UInt32 {
    return adeviceEvent.which
  }
  public var iscapture: UInt8 {
    return adeviceEvent.iscapture
  }

  public override var description: String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), which:\(which) " +
        "iscapture:\(iscapture))"
  }
}
