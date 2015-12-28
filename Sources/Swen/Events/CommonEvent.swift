import Foundation
import CSDL

// Uint32 type;
// Uint32 timestamp;

public class CommonEvent : BaseEvent {
  private var common: SDL_CommonEvent {
    return self.handle.memory.common
  }

  var timestamp: UInt32 {
    return common.timestamp
  }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp))"
  }
}