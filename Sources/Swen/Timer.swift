import Foundation
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