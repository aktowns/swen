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

public class SwenDemo: GameBaseDelegate {
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

  var hudSpriteMapping: [String:Rect]
  var hudSpriteTexture: Texture

  var player: Player
  var enemy: Enemy
  var item1: Item
  var item2: Item
  var item3: Item

  var phydebug: PhyDebug

  // Setup
  public required init(withWindow window: Window, pipeline: ContentPipeline, andGame game: Game) {
    self.window = window
    self.pipeline = pipeline

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

      self.player = try Player(pipeline: pipeline)
      self.player.registerInSpace(game.space, withTag: "player")

      self.enemy = try Enemy(pipeline: pipeline)
      self.enemy.registerInSpace(game.space, withTag: "enemy")

      self.item1 = try Item(pipeline: pipeline)
      self.item1.position = Vector(x: 920.0, y: 370.0)
      self.item1.registerInSpace(game.space, withTag: "item")

      self.item2 = try Item(pipeline: pipeline)
      self.item2.position = Vector(x: 1020.0, y: 370.0)
      self.item2.registerInSpace(game.space, withTag: "item")

      self.item3 = try Item(pipeline: pipeline)
      self.item3.position = Vector(x: 1120.0, y: 370.0)
      self.item3.registerInSpace(game.space, withTag: "item")

    } catch let error as SDLError {
      fatalError("Failed to create a window: \(error.description)")
    } catch {
      fatalError("Unexpected error occured")
    }

    let debugDraw = PhyDebugSDL(withRenderer: pipeline.renderer!)

    self.phydebug = PhyDebug(delegate: debugDraw)

    let ground: PhyShape = PhyShape(segmentedShapeFrom: game.space.staticBody,
        a: Vector(x: 0.0, y: window.size.sizeY),
        b: Vector(x: window.size.sizeX, y: window.size.sizeY),
        radius: 50.0)
    ground.tag = "wall"
    ground.friction = 1.0
    ground.elasticity = 1.0
    game.space.addShape(ground)

    let rwall: PhyShape = PhyShape(segmentedShapeFrom: game.space.staticBody,
        a: Vector(x: window.size.sizeX, y: 0),
        b: Vector(x: window.size.sizeX, y: window.size.sizeY),
        radius: 50.0)
    rwall.tag = "wall"
    rwall.friction = 1.0
    rwall.elasticity = 1.0
    game.space.addShape(rwall)

    let lwall: PhyShape = PhyShape(segmentedShapeFrom: game.space.staticBody,
        a: Vector(x: 0.0, y: 0),
        b: Vector(x: 0.0, y: window.size.sizeY),
        radius: 50.0)
    lwall.tag = "wall"
    lwall.friction = 1.0
    lwall.elasticity = 1.0
    game.space.addShape(lwall)


    let twall: PhyShape = PhyShape(segmentedShapeFrom: game.space.staticBody,
        a: Vector(x: 0.0, y: 0),
        b: Vector(x: window.size.sizeX, y: 0),
        radius: 50.0)
    twall.tag = "wall"
    twall.friction = 1.0
    twall.elasticity = 1.0
    game.space.addShape(twall)

//    let body = game.space.addBody(PhyBody(mass: 20.0, moment: Double.infinity))
//    body.position = player.position
//    let shape = game.space.addShape(PhyShape(boxShapeFrom: body,
//        box: PhyBoundingBox(size: Rect(x: -30, y: 250.0, sizeX: 30.0, sizeY: -250.0)), radius: 10.0))
//        //topLeft: Vector(x: -30.0, y: 50.0), bottomRight: Vector(x: 30.0, y: -50.0)), radius: 10.0))
//    shape.elasticity = 0.5
//    shape.friction = 0.0
//    shape.collisionType = 1
//    shape.tag = "player"
//
//    self.playerBody = body
//    self.playerShape = shape

//    for i: Int32 in Range(start: 0, end: 3) {
//      for j in Range(start: 0, end: 3) {
//        let body = game.space.addBody(PhyBody(mass: 1.0, moment: Double.infinity))
//        body.position = Vector.fromInt32(x: 600 + j * 120, y: 200 + i * 120)
//
//        let shape = game.space.addShape(PhyShape(boxShapeFrom: body, size: Size(sizeX: 50.0, sizeY: 50.0), radius: 0.0))
//        shape.elasticity = 0.8
//        shape.friction = 0.7
//        shape.tag = "box"
//      }
//    }
//
//    let radius: Double = 15
//    let mass: Double = 1
//
//    let moment = PhyMisc.momentForCircle(m: mass, r1: 0, r2: radius, offset: Vector.zero)
//
//    for i: Int32 in Range(start: 0, end: 30) {
//      for j in Range(start: 0, end: 30) {
//        let ballBody = game.space.addBody(PhyBody(mass: mass, moment: moment))
//        ballBody.position = Vector.fromInt32(x: 600 + j * 120, y: 200 + i * 120)
//
//        let ballShape = game.space.addShape(PhyShape(circleShapeFrom: ballBody,
//            radius: radius, offset: Vector.zero))
//        ballShape.friction = 1
//        ballShape.elasticity = 1.0
//        ballShape.tag = "ball"
//      }
//    }

//    let playerMass: Double = 1
//
//    let playerMoment = PhyMisc.momentForBox(m: playerMass,
//        width: player.size.sizeX, height: player.size.sizeY)
//
//    let playerBody = space.addBody(PhyBody(mass: playerMass, moment: playerMoment))
//    playerBody.position = player.position
//
//    let playerShape = space.addShape(PhyShape(boxShapeFrom: playerBody,
//        width: player.size.sizeX, height: player.size.sizeY, radius: 10))
//    playerShape.friction = 1
//    playerShape.elasticity = 0
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

    enemy.draw(game)
    item1.draw(game)
    item2.draw(game)
    item3.draw(game)
    player.draw(game)

    game.space.debugDraw(phydebug)
  }

  // Game logic
  public func update(game: Game) {
    if let statusText = try? normalFont.asTexture(withText: "FPS: \(game.fps)", size: 28, andColour: Colour.black) {
      self.statusText = statusText
    }

    for keyEvent in game.keyEvents {
      if !keyEvent.keyRepeat {
        switch keyEvent.scanCode {
        case .ScanCodeUp:
          player.direction.y += (keyEvent.state == KeyState.Pressed) ? 1.0 : -1.0
        case .ScanCodeDown:
          player.direction.y += (keyEvent.state == KeyState.Pressed) ? -1.0 : 1.0
        case .ScanCodeRight:
          player.direction.x += (keyEvent.state == KeyState.Pressed) ? 1.0 : -1.0
        case .ScanCodeLeft:
          player.direction.x += (keyEvent.state == KeyState.Pressed) ? -1.0 : 1.0
        default: Void()
        }
        print(keyEvent)
      }
    }

    enemy.update(game)
    item1.update(game)
    item2.update(game)
    item3.update(game)
    player.update(game)
  }
}
