//
//   Event.swift created on 28/12/15
//   Swen project
//
//   Copyright 2015 Ashley Towns <code@ashleytowns.id.au>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

import CSDL

public class SDLEvent {

  public class func poll(f: (BaseEvent) -> Void) {
    var e: SDL_Event = SDL_Event()

    while SDL_PollEvent(&e) != 0 {
      f(SDLEvent.coerce(e))
    }
  }

  public class func wait(f: (BaseEvent) -> Void) {
    var e: SDL_Event = SDL_Event()

    while SDL_WaitEvent(&e) != 0 {
      f(SDLEvent.coerce(e))
    }
  }

  private class func coerce(e: SDL_Event) -> BaseEvent {
    let type = SDL_EventType(e.type)

    switch type {
    case SDL_AUDIODEVICEADDED,
         SDL_AUDIODEVICEREMOVED: return AudioDeviceEvent(handle: e)
    case SDL_CONTROLLERAXISMOTION: return ControllerAxisEvent(handle: e)
    case SDL_CONTROLLERBUTTONDOWN,
         SDL_CONTROLLERBUTTONUP: return ControllerButtonEvent(handle: e)
    case SDL_CONTROLLERDEVICEADDED,
         SDL_CONTROLLERDEVICEREMOVED,
         SDL_CONTROLLERDEVICEREMAPPED: return ControllerDeviceEvent(handle: e)
    case SDL_DROPFILE: return DropEvent(handle: e)
    case SDL_JOYAXISMOTION: return JoyAxisEvent(handle: e)
    case SDL_JOYBALLMOTION: return JoyBallEvent(handle: e)
    case SDL_JOYHATMOTION: return JoyHatEvent(handle: e)
    case SDL_JOYBUTTONDOWN,
         SDL_JOYBUTTONUP: return JoyButtonEvent(handle: e)
    case SDL_JOYDEVICEADDED,
         SDL_JOYDEVICEREMOVED: return JoyDeviceEvent(handle: e)
    case SDL_KEYUP, SDL_KEYDOWN: return KeyboardEvent(handle: e)
    case SDL_MOUSEBUTTONDOWN,
         SDL_MOUSEBUTTONUP: return MouseButtonEvent(handle: e)
    case SDL_MOUSEMOTION: return MouseMotionEvent(handle: e)
    case SDL_MOUSEWHEEL: return MouseWheelEvent(handle: e)
    case SDL_QUIT: return QuitEvent(handle: e)
    case SDL_SYSWMEVENT: return SysWMEvent(handle: e)
    case SDL_TEXTEDITING: return TextEditingEvent(handle: e)
    case SDL_TEXTINPUT: return TextInputEvent(handle: e)
    case SDL_USEREVENT: return UserEvent(handle: e)
    case SDL_WINDOWEVENT: return WindowEvent(handle: e)
    default: return BaseEvent(handle: e)
    }
  }

}
