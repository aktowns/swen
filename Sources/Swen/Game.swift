import CSDL

public class Game {
  let window: Window
  let windowSize: Size<Int32> = Size(w: 1920, h: 1080)
  let pipeline: ContentPipeline

  public init() throws {
    try SDL.initSDL()

    self.window = try Window(withTitle: "swen2d", andSize: windowSize)
    self.pipeline = ContentPipeline()
  }

  public func loadMedia() throws -> Void {
    window.renderer.clear()

    let backdrop: ImageFile = pipeline.get(fromPath: "assets/backgrounds/colored_grass.png")!
    let backdropTexture = try backdrop.asTexture(withRenderer: window.renderer)

    backdropTexture.render()

    // let normalFont: FontFile = pipeline.get(fromPath: "assets/fonts/KenPixel.ttf")!
    let blockFont: FontFile = pipeline.get(fromPath: "assets/fonts/KenPixel Blocks.ttf")!

    let demoTexture = try blockFont.asTexture(withText: "swEn demo",
        size: 68, colour: Colour.black, andRenderer: window.renderer)

    demoTexture.render(atPoint: Point(x: (windowSize.w - demoTexture.size.w) / 2, y: 25))

    let playerStandingFile: ImageFile = pipeline.get(fromPath: "assets/sprites/player/alienBlue_stand.png")!
    let playerStanding = try playerStandingFile.asTexture(withRenderer: window.renderer)

    playerStanding.render(atPoint: Point(x: 120, y: 390))

    let hud1File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud1.png")!
    let hud3File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud3.png")!
    let hudHeartFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudHeart_full.png")!
    let hudJewelFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudJewel_green.png")!

    let hud1 = try hud1File.asTexture(withRenderer: window.renderer)
    let hud3 = try hud3File.asTexture(withRenderer: window.renderer)
    let hudHeart = try hudHeartFile.asTexture(withRenderer: window.renderer)
    let hudJewel = try hudJewelFile.asTexture(withRenderer: window.renderer)

    let bottomScreen = windowSize.h - (hudHeart.size.h + 10)

    hudHeart.render(atPoint: Point(x: 10, y: bottomScreen))
    hud3.render(atPoint: Point(x: hudHeart.size.w, y: bottomScreen))

    hud1.render(atPoint: Point(x: windowSize.w - (hud1.size.w + 10), y: bottomScreen))
    hudJewel.render(atPoint: Point(x: windowSize.w - (hud1.size.w + hudJewel.size.w), y: bottomScreen))

    let mus = Mix_LoadMUS("assets/music/Retro Comedy.ogg")
    Mix_PlayMusic(mus, -1)

    window.renderer.present()
  }

  public func close() -> Void {
    SDL.quitSDL()
    exit(-1)
  }
}
