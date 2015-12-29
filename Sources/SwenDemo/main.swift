import Swen

let game = try! GameBase(withTitle: "swEn Demo", size: Size(w: 1920, h: 1080), andDelegate: SwenDemo.self)
game.start()
game.close()