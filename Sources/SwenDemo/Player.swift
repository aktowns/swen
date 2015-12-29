import Swen

public class Player : GameLoop {
  private let pipeline: ContentPipeline

  var player: Texture

  public init(pipeline: ContentPipeline) throws {
    self.pipeline = pipeline

    let playerStandingFile: ImageFile = pipeline.get(fromPath: "assets/sprites/player/alienBlue_stand.png")!
    self.player = try playerStandingFile.asTexture()
  }

  public func draw() {
    player.render(atPoint: Point(x: 120, y: 390))
  }

  public func loop() {

  }
}