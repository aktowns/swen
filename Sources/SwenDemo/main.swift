import Swen

public class SwenDemo : GameBaseDelegate {
  let window: Window
  let pipeline: ContentPipeline

  var backdrop: Texture
  var statusText: Texture
  var titleText: Texture

  var normalFont: FontFile
  var blockFont: FontFile

  var player: Texture
  var hud1: Texture
  var hud3: Texture
  var hudHeart: Texture
  var hudJewel: Texture

  // Setup
  public required init(withWindow window: Window, andPipeline pipeline: ContentPipeline) {
    self.window = window
    self.pipeline = pipeline

    do {
      let backdropFile: ImageFile = pipeline.get(fromPath: "assets/backgrounds/colored_grass.png")!
      let playerStandingFile: ImageFile = pipeline.get(fromPath: "assets/sprites/player/alienBlue_stand.png")!
      let hud1File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud1.png")!
      let hud3File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud3.png")!
      let hudHeartFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudHeart_full.png")!
      let hudJewelFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudJewel_green.png")!

      self.normalFont = pipeline.get(fromPath: "assets/fonts/KenPixel.ttf")!
      self.blockFont = pipeline.get(fromPath: "assets/fonts/KenPixel Blocks.ttf")!

      self.backdrop = try backdropFile.asTexture()
      self.titleText = try blockFont.asTexture(withText: "swEn demo", size: 68, andColour: Colour.black)
      self.statusText = try normalFont.asTexture(withText: "Testing", size: 28, andColour: Colour.black)
      self.player = try playerStandingFile.asTexture()
      self.hud1 = try hud1File.asTexture()
      self.hud3 = try hud3File.asTexture()
      self.hudHeart = try hudHeartFile.asTexture()
      self.hudJewel = try hudJewelFile.asTexture()

    } catch let error as SDLError {
      fatalError("Failed to create a window: \(error.description)")
    } catch {
      fatalError("Unexpected error occured")
    }
  }

  // Rendering
  public func draw() {
    backdrop.render()
    titleText.render(atPoint: Point(x: (window.size.w - titleText.size.w) / 2, y: 25))

    player.render(atPoint: Point(x: 120, y: 390))

    hudHeart.render(atPoint: Point(x: 10, y: window.size.h - hudHeart.size.h))
    hud3.render(atPoint: Point(x: hudHeart.size.w, y: window.size.h - hud3.size.h))

    hud1.render(atPoint: Point(x: window.size.w - (hud1.size.w + 10), y: window.size.h - hud1.size.h))
    hudJewel.render(atPoint: Point(x: window.size.w - (hud1.size.w + hudJewel.size.w), y: window.size.h - hudJewel.size.h))
  }

  // Game logic
  public func loop() {

  }
}

let game = try! GameBase(withTitle: "swEn Demo", size: Size(w: 1920, h: 1080), andDelegate: SwenDemo.self)
game.start()
game.close()