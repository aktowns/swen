//
//   Timer.swift created on 28/12/15
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

public class Timer {
  var startTicks: UInt32 = 0
  var pauseTicks: Uint32 = 0
  var paused: Bool = false
  var started: Bool = false

  public func start() {
    self.started = true
    self.paused = false

    self.startTicks = 0
    self.pauseTicks = 0
  }

  public func stop() {
    self.started = false
    self.paused = false

    self.startTicks = 0
    self.pauseTicks = 0
  }

  public func pause() {
    if self.started && !self.paused {
      self.paused = true

      self.pauseTicks = Timer.globalTicks() - self.startTicks
      self.startTicks = 0
    }
  }

  public func unpause() {
    if self.started && self.paused {
      self.paused = false

      self.startTicks = Timer.globalTicks() - self.pauseTicks
      self.pauseTicks = 0
    }
  }

  public func ticks() -> UInt32 {
    var time: Uint32 = 0

    if started {
      if paused {
        time = self.pauseTicks
      } else {
        time = Timer.globalTicks() - startTicks
      }
    }

    return time
  }

  public static func globalTicks() -> UInt32 {
    return SDL_GetTicks()
  }
}
