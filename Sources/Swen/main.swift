
do {
  let game = try Game()
  try game.loadMedia()

  while true {
    Event.wait { event in
      switch event {
      case is QuitEvent: game.close()
//      case let kbd    as KeyboardEvent: print(kbd)
//      case let win    as WindowEvent: print(win)
//      case let wm     as SysWMEvent: print(wm)
//      case let mouse  as MouseMotionEvent: print(mouse)
//      case let mouse  as MouseButtonEvent: print(mouse)
//      case let joy    as JoyDeviceEvent: print(joy)
//      default: print(event)
        default: Void()
      }
    }
  }
} catch let error as SDLError {
  print(error.description)
} catch {
  print("Unexpected error")
}
