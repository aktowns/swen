import Foundation
import CSDL

// Uint32 type;                                /**< ::SDL_TEXTEDITING */
// Uint32 timestamp;
// Uint32 windowID;                            /**< The window with keyboard focus, if any */
// char text[SDL_TEXTEDITINGEVENT_TEXT_SIZE];  /**< The editing text */
// Sint32 start;                               /**< The start cursor of selected editing text */
// Sint32 length;                              /**< The length of selected editing text */

public class TextEditingEvent : CommonEvent {
  private var editMem: SDL_TextEditingEvent { return self.handle.memory.edit }

  public var windowId: UInt32 { return editMem.windowID }
  public var text: String? {
    // for some reason fixed width arrays are converted to tuples..
    let mirror: Array<Int8> = Mirror(reflecting: editMem.text).children.map{$0.value as! Int8}
    return String.fromCString(UnsafePointer(mirror))
  }
  public var start: Int32 { return editMem.start }
  public var length: Int32 { return editMem.length }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), " +
        "windowId:\(windowId), text:\(text), start:\(start), length:\(length))"
  }
}