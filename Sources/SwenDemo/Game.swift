//
//   Game.swift created on 29/12/15
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

import Swen
import Glibc

public class SwenDemo : GameBaseDelegate {
  let window: Window
  let pipeline: ContentPipeline

  var backdrop: Texture
  var statusText: Texture
  var titleText: Texture

  var normalFont: FontFile
  var blockFont: FontFile

  var hud1: Texture
  var hud3: Texture
  var hudHeart: Texture
  var hudJewel: Texture

  var hudSpriteMapping: [String: Rect]
  var hudSpriteTexture: Texture

  var player: Player
  var enemy: Enemy
  var item1: Item
  var item2: Item
  var item3: Item

  var space: PhySpace
  var phydebug: PhyDebug
  let timeStep = 1.0/100.0
  var physicsStep: Double = 0

  // Setup
  public required init(withWindow window: Window, pipeline: ContentPipeline, andSpace space: PhySpace) {
    self.window = window
    self.pipeline = pipeline
    self.space = space

    do {
      let backdropFile: ImageFile = pipeline.get(fromPath: "assets/backgrounds/blue_grass.png")!

      let hudSpriteMap: ImageMapFile = pipeline.get(fromPath: "assets/sprites/spritesheet_hud.xml")!
      self.hudSpriteMapping = hudSpriteMap.mapping
      self.hudSpriteTexture = try hudSpriteMap.imageFile.asTexture()

      let hud1File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud1.png")!
      let hud3File: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hud3.png")!
      let hudHeartFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudHeart_full.png")!
      let hudJewelFile: ImageFile = pipeline.get(fromPath: "assets/sprites/hud/hudJewel_green.png")!

      self.normalFont = pipeline.get(fromPath: "assets/fonts/KenPixel.ttf")!
      self.blockFont = pipeline.get(fromPath: "assets/fonts/KenPixel Blocks.ttf")!

      self.backdrop = try backdropFile.asTexture()
      self.titleText = try blockFont.asTexture(withText: "swEn demo", size: 68, andColour: Colour.black)
      self.statusText = try normalFont.asTexture(withText: "Testing", size: 28, andColour: Colour.black)

      self.hud1 = try hud1File.asTexture()
      self.hud3 = try hud3File.asTexture()
      self.hudHeart = try hudHeartFile.asTexture()
      self.hudJewel = try hudJewelFile.asTexture()

      self.player = try Player(pipeline: pipeline, space: space)
      self.enemy = try Enemy(pipeline: pipeline)
      self.item1 = try Item(pipeline: pipeline, position: Vector(x: 920.0, y: 370.0))
      self.item2 = try Item(pipeline: pipeline, position: Vector(x: 1020.0, y: 370.0))
      self.item3 = try Item(pipeline: pipeline, position: Vector(x: 1120.0, y: 370.0))
    } catch let error as SDLError {
      fatalError("Failed to create a window: \(error.description)")
    } catch {
      fatalError("Unexpected error occured")
    }

    let debugDraw = PhysicsDebugger(withRenderer: pipeline.renderer!)

    self.phydebug = PhyDebug(delegate: debugDraw)
    space.gravity = Vector(x: 0.0, y: 0.5)

    let ground: PhyShape = PhyShape(segmentedShapeFrom: space.staticBody,
        a: Vector(x: -20, y: window.size.sizeY - 430),
        b: Vector(x: window.size.sizeX + 20, y: window.size.sizeY - 430),
        radius: 20)
    ground.friction = 1
    ground.elasticity = 1
    space.addShape(ground)

    let rwall: PhyShape = PhyShape(segmentedShapeFrom: space.staticBody,
        a: Vector(x: window.size.sizeX - 20, y: -20.0),
        b: Vector(x: window.size.sizeX - 20, y: window.size.sizeY + 20),
        radius: 20.0)
    rwall.friction = 1
    rwall.elasticity = 0.7
    space.addShape(rwall)

    let playerMass: Double = 1

    let playerMoment = PhyMisc.momentForBox(m: playerMass,
        width: player.size.sizeX, height: player.size.sizeY)

    let playerBody = space.addBody(PhyBody(mass: playerMass, moment: playerMoment))
    playerBody.position = player.position

    let playerShape = space.addShape(PhyShape(boxShapeFrom: playerBody,
        width: player.size.sizeX, height: player.size.sizeY, radius: 10))
    playerShape.friction = 1
    playerShape.elasticity = 0

    let radius: Double = 20
    let mass: Double = 1

    let moment = PhyMisc.momentForCircle(m: mass, r1: 0, r2: radius, offset: Vector.zero)

    let ballBody = space.addBody(PhyBody(mass: mass, moment: moment))
    ballBody.position = Vector(x: 200.0, y: 0.0)
    ballBody.velocity = Vector.zero

    let ballShape = space.addShape(PhyShape(circleShapeFrom: ballBody,
        radius: radius, offset: Vector.zero))
    ballShape.friction = 1
    ballShape.elasticity = 0.3
  }

  // Rendering
  public func draw(game: Game) {
    backdrop.render()

    titleText.render(atPoint: Vector(x: (window.size.sizeX - titleText.size.sizeX) / 2, y: 25))
    statusText.render(atPoint: Vector(x: 10.0, y: 10.0))

    hudHeart.render(atPoint: Vector(x: 10, y: window.size.sizeY - hudHeart.size.sizeY))
    hud3.render(atPoint: Vector(x: hudHeart.size.sizeX, y: window.size.sizeY - hud3.size.sizeY))

    hud1.render(atPoint: Vector(x: window.size.sizeX - (hud1.size.sizeX + 10),
        y: window.size.sizeY - hud1.size.sizeY))
    hudJewel.render(atPoint: Vector(x: window.size.sizeX - (hud1.size.sizeX + hudJewel.size.sizeX),
        y: window.size.sizeY - hudJewel.size.sizeY))

    space.debugDraw(phydebug)

    enemy.draw(game)
    item1.draw(game)
    item2.draw(game)
    item3.draw(game)
    player.draw(game)

  }

  // Game logic
  public func loop(game: Game) {
    if let statusText = try? normalFont.asTexture(withText: "FPS: \(game.fps)", size: 28, andColour: Colour.black) {
      self.statusText = statusText
    }

    for keyEvent in game.keyEvents {
      print(keyEvent)
    }

    enemy.loop(game)
    item1.loop(game)
    item2.loop(game)
    item3.loop(game)
    player.loop(game)

    space.step(Double(game.frame) / 100)
  }
}