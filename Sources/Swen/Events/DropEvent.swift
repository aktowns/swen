import Foundation
import CSDL

// Uint32 type;        /**< ::SDL_DROPFILE */
// Uint32 timestamp;
// char *file;         /**< The file name, which should be freed with SDL_free() */

public class DropEvent : CommonEvent {
  private var dropMem: SDL_DropEvent { return self.handle.memory.drop }

  public var file: String? { return String.fromCString(dropMem.file) }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), file:\(file))"
  }
}