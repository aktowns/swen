import Foundation
import CSDL

public class BaseEvent : CustomStringConvertible {
  let handle: RawEvent

  init(handle: RawEvent) {
    self.handle = handle
  }

  var type: SDL_EventType {
    return SDL_EventType(self.handle.memory.type)
  }

  public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type))"
  }
}
