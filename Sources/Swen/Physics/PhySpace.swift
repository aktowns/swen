//
//   PhySpace.swift created on 30/12/15
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

import CChipmunk

// 0 typedef enum cpSpaceDebugDrawFlags {
// 281 > CP_SPACE_DEBUG_DRAW_SHAPES = 1<<0,
// 282 > CP_SPACE_DEBUG_DRAW_CONSTRAINTS = 1<<1,
// 283 > CP_SPACE_DEBUG_DRAW_COLLISION_POINTS = 1<<2,
// 284 } cpSpaceDebugDrawFlags;

public final class PhySpace : LowLevelMemoizedHandle {
  public let handle: COpaquePointer
  public static var memoized: [COpaquePointer: PhySpace] = Dictionary<COpaquePointer, PhySpace>()

  public init(fromHandle handle: COpaquePointer) {
    self.handle = handle

    assert(handle != nil, "PhySpace.init(fromHandle:) handed a null handle")

    assert(PhySpace.memoized[handle] == nil, "PhySpace.init(fromHandle:) initialised with tagged handler")

    PhySpace.memoized[handle] = self
  }

  // try UserData falling back to creating a new instance
  public static func fromHandle(handle: COpaquePointer) -> PhySpace {
    let mptr = PhySpace.memoized[handle]

    if let ptr = mptr {
      return ptr
    }

    return PhySpace(fromHandle: handle)
  }

  public convenience init() {
    let space = cpSpaceNew()

    self.init(fromHandle: space)
  }

  deinit {
    cpSpaceFree(self.handle)
  }

  public func addShape(shape: PhyShape) -> PhyShape {
    let shape = cpSpaceAddShape(self.handle, shape.handle)

    return PhyShape.fromHandle(shape)
  }

  public func addBody(body: PhyBody) -> PhyBody {
    let body = cpSpaceAddBody(self.handle, body.handle)

    return PhyBody.fromHandle(body)
  }

  public func step(dt: Double) {
    cpSpaceStep(self.handle, dt)
  }

  public func debugDraw(opts: PhyDebug) {
    var config = opts.generateStruct()
    cpSpaceDebugDraw(self.handle, &config)
  }

  public func reindexShapes(forBody body: PhyBody) {
    cpSpaceReindexShapesForBody(self.handle, body.handle)
  }

  public func reindexShape(shape: PhyShape) {
    cpSpaceReindexShape(self.handle, shape.handle)
  }

  public func reindexStatic() {
    cpSpaceReindexStatic(self.handle)
  }

  public var gravity: Vector {
    get {
      return cpSpaceGetGravity(self.handle).toVector()
    }
    set {
      cpSpaceSetGravity(self.handle, cpVect.fromVector(newValue))
    }
  }

  public var iterations: Int32 {
    get {
      return cpSpaceGetIterations(self.handle)
    }
    set {
      cpSpaceSetIterations(self.handle, newValue)
    }
  }

  public var staticBody: PhyBody {
    return PhyBody.fromHandle(cpSpaceGetStaticBody(self.handle))
  }
}

