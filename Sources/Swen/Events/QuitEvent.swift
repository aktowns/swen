import Foundation

// Uint32 type;        /**< ::SDL_QUIT */
// Uint32 timestamp;

public class QuitEvent : CommonEvent {
  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp))"
  }
}
