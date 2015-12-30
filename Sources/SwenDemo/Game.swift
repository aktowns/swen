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

public class PhysicsDebugger : PhyDebugDrawDelegate {
  let renderer : Renderer

  init(withRenderer: Renderer) {
    self.renderer = withRenderer
  }

  public func drawSegment(a a: Vector<Double>, b: Vector<Double>, color: Colour) {
    renderer.draw(startingFrom: Point<Int32>(x: Int32(a.x), y: Int32(a.y)),
        endingAt: Point(x: Int32(b.x), y: Int32(b.y)))
  }

  public func drawDot(size size: Double, pos: Vector<Double>, color: Colour) {

  }

  public func drawCircle(pos pos: Vector<Double>,
                         angle: Double,
                         radius: Double,
                         outlineColor: Colour,
                         fillColor: Colour) {
    print("x: \(Int16(pos.x)) y: \(Int16(pos.y))")

    renderer.fillCircle(Point(x: Int16(pos.x / 2), y: Int16(-pos.y / 2)), rad: Int16(radius * 5), colour: fillColor)
  }

  public func drawColour(shape shape: COpaquePointer) -> Colour {
    return Colour(r: 255, g: 0, b: 0, a:120)
  }

  public func drawFatSegment(a a: Vector<Double>,
                             b: Vector<Double>,
                             radius: Double,
                             outlineColor: Colour,
                             fillColor: Colour) {

  }

  public func drawPolygon(count count: Int32,
                          //verts: UnsafePointer<cpVect>,
                          radius: Double,
                          outlineColor: Colour,
                          fillColor: Colour) {

  }
}

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

  var hudSpriteMapping: [String: Rect<Int32>]
  var hudSpriteTexture: Texture

  var player: Player
  var enemy: Enemy
  var item1: Item
  var item2: Item
  var item3: Item

  var space: PhySpace
  var phydebug: PhyDebug
  let timeStep = 1.0/60.0
  var physicsStep: Double = 0

  // Setup
  public required init(withWindow window: Window, andPipeline pipeline: ContentPipeline) {
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
      self.enemy = try Enemy(pipeline: pipeline)
      self.item1 = try Item(pipeline: pipeline, position: Point(x: 920, y: 370))
      self.item2 = try Item(pipeline: pipeline, position: Point(x: 1020, y: 370))
      self.item3 = try Item(pipeline: pipeline, position: Point(x: 1120, y: 370))
    } catch let error as SDLError {
      fatalError("Failed to create a window: \(error.description)")
    } catch {
      fatalError("Unexpected error occured")
    }

    self.space = PhySpace()

    let debugDraw = PhysicsDebugger(withRenderer: pipeline.renderer!)

    self.phydebug = PhyDebug(delegate: debugDraw)
    space.gravity = Vector(x: 0, y: -100)
    let ground: PhyShape = PhyShape(segmentedShapeFrom: space.staticBody,
        a: Vector(x: -10, y: 5), b: Vector(x: 40, y: -5), radius: 0)
    ground.friction = 1
    ground.elasticity = 0.5
    space.addShape(ground)

    let radius: Double = 5
    let mass: Double = 1

    let moment = PhyMisc.momentForCircle(m: mass, r1: 0, r2: radius, offset: Vector<Double>(x: 0, y: 0))

    let ballBody = space.addBody(PhyBody(mass: mass, moment: moment))
    ballBody.position = Vector(x: 0, y: 15)

    let ballShape = space.addShape(PhyShape(circleShapeFrom: ballBody,
        radius: radius, offset: Vector<Double>(x:0, y:0)))
    ballShape.friction = 0.7
    ballShape.elasticity = 10.0


//    for time in Double(0).stride(to: Double(20), by: timeStep) {
//      //let pos = ballBody.position
//      //let vel = ballBody.velocity
//
//      //print("time is \(time), ballBody is at \(pos). its velocity is \(vel)")
//      space.step(time)
//    }
  }

  // Rendering
  public func draw(game: Game) {
    backdrop.render()

    titleText.render(atPoint: Point(x: (window.size.w - titleText.size.w) / 2, y: 25))
    statusText.render(atPoint: Point<Int32>(x: 10, y: 10))

    hudHeart.render(atPoint: Point(x: 10, y: window.size.h - hudHeart.size.h))
    hud3.render(atPoint: Point(x: hudHeart.size.w, y: window.size.h - hud3.size.h))

    hud1.render(atPoint: Point(x: window.size.w - (hud1.size.w + 10), y: window.size.h - hud1.size.h))
    hudJewel.render(atPoint: Point(x: window.size.w - (hud1.size.w + hudJewel.size.w), y: window.size.h - hudJewel.size.h))

    enemy.draw(game)
    item1.draw(game)
    item2.draw(game)
    item3.draw(game)
    player.draw(game)

    space.debugDraw(phydebug)
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

    if physicsStep < 0.5 {
      space.step(physicsStep)
      print(physicsStep)
      physicsStep += timeStep
    }
  }
}