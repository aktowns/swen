import CSDL

// Uint32 type;
// Uint32 timestamp;

public class CommonEvent : BaseEvent {
  private var commonEvent: SDL_CommonEvent { return self.handle.common }

  var timestamp: UInt32 { return commonEvent.timestamp }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp))"
  }
}