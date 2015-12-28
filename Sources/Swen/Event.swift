import Foundation
import CSDL
import Glibc

typealias RawEvent = UnsafeMutablePointer<SDL_Event>

public class Event {
  // public class func peepEvent
  // public class func hasEvent
  // public class func hasEvents
  // public class func flushEvent
  // public class func flushEvents

  public class func poll(f: (BaseEvent) -> Void) -> Void {
    let e: RawEvent = RawEvent.alloc(1)

    while SDL_PollEvent(e) != 0 {
      f(Event.coerce(e))
    }
  }

  public class func wait(f: (BaseEvent) -> Void) -> Void {
    let e: RawEvent = RawEvent.alloc(1)

    while SDL_WaitEvent(e) != 0 {
      f(Event.coerce(e))
    }
  }

  private class func coerce(e: RawEvent) -> BaseEvent {
    let type = SDL_EventType(e.memory.type)

    switch type {
    case SDL_AUDIODEVICEADDED,
         SDL_AUDIODEVICEREMOVED:        return AudioDeviceEvent(handle: e)
    case SDL_CONTROLLERAXISMOTION:      return ControllerAxisEvent(handle: e)
    case SDL_CONTROLLERBUTTONDOWN,
         SDL_CONTROLLERBUTTONUP:        return ControllerButtonEvent(handle: e)
    case SDL_CONTROLLERDEVICEADDED,
         SDL_CONTROLLERDEVICEREMOVED,
         SDL_CONTROLLERDEVICEREMAPPED:  return ControllerDeviceEvent(handle: e)
    case SDL_DROPFILE:                  return DropEvent(handle: e)
    case SDL_JOYAXISMOTION:             return JoyAxisEvent(handle: e)
    case SDL_JOYBALLMOTION:             return JoyBallEvent(handle: e)
    case SDL_JOYHATMOTION:              return JoyHatEvent(handle: e)
    case SDL_JOYBUTTONDOWN,
         SDL_JOYBUTTONUP:               return JoyButtonEvent(handle: e)
    case SDL_JOYDEVICEADDED,
         SDL_JOYDEVICEREMOVED:          return JoyDeviceEvent(handle: e)
    case SDL_KEYUP, SDL_KEYDOWN:        return KeyboardEvent(handle: e)
    case SDL_MOUSEBUTTONDOWN,
         SDL_MOUSEBUTTONUP:             return MouseButtonEvent(handle: e)
    case SDL_MOUSEMOTION:               return MouseMotionEvent(handle: e)
    case SDL_MOUSEWHEEL:                return MouseWheelEvent(handle: e)
    case SDL_QUIT:                      return QuitEvent(handle: e)
    case SDL_SYSWMEVENT:                return SysWMEvent(handle: e)
    case SDL_TEXTEDITING:               return TextEditingEvent(handle: e)
    case SDL_TEXTINPUT:                 return TextInputEvent(handle: e)
    case SDL_USEREVENT:                 return UserEvent(handle: e)
    case SDL_WINDOWEVENT:               return WindowEvent(handle: e)
    default:                            return BaseEvent(handle: e)

    }
  }
}
