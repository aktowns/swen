import CSDL

public class BaseEvent : CustomStringConvertible {
  let handle: SDL_Event

  init(handle: SDL_Event) {
    self.handle = handle
  }

  var type: SDL_EventType {
    return SDL_EventType(handle.type)
  }

  public var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type))"
  }
}
