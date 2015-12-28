import Foundation
import CSDL

// Uint32 type;                              /**< ::SDL_TEXTINPUT */
// Uint32 timestamp;
// Uint32 windowID;                          /**< The window with keyboard focus, if any */
// char text[SDL_TEXTINPUTEVENT_TEXT_SIZE];  /**< The input text */

public class TextInputEvent : CommonEvent {
  private var textMem: SDL_TextInputEvent { return self.handle.memory.text }

  public var windowId: UInt32 { return textMem.windowID }
  public var text: String? {
    // for some reason fixed width arrays are converted to tuples..
    let mirror: Array<Int8> = Mirror(reflecting: textMem.text).children.map{$0.value as! Int8}
    return String.fromCString(UnsafePointer(mirror))
  }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), " +
        "windowId:\(windowId), text:\(text))"
  }
}