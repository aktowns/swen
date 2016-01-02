//
//   PhyShape.swift created on 30/12/15
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

public final class PhyShape: LowLevelMemoizedHandle {
  public let handle: COpaquePointer
  public var tag: String?
  public static var memoized: [COpaquePointer: PhyShape] = Dictionary<COpaquePointer, PhyShape>()

  public required init(fromHandle handle: COpaquePointer) {
    self.handle = handle
    self.tag = Optional.None

    assert(handle != nil, "PhyShape.init(fromHandle:) handed a null handle")

    assert(PhyShape.memoized[handle] == nil, "PhyShape.init(fromHandle:) initialised with tagged handler")

    PhyShape.memoized[handle] = self
  }

  // try UserData falling back to creating a new instance
  public static func fromHandle(handle: COpaquePointer) -> PhyShape {
    let mptr = PhyShape.memoized[handle]

    if let ptr = mptr {
      return ptr
    }

    return PhyShape(fromHandle: handle)
  }

  public convenience init(segmentedShapeFrom body: PhyBody, a: Vector, b: Vector, radius: Double) {
    let ptr = cpSegmentShapeNew(body.handle, cpVect.fromVector(a), cpVect.fromVector(b), radius)

    self.init(fromHandle: ptr)
  }

  public convenience init(circleShapeFrom body: PhyBody, radius: Double, offset: Vector) {
    let ptr = cpCircleShapeNew(body.handle, radius, cpVect.fromVector(offset))

    self.init(fromHandle: ptr)
  }

  public convenience init(boxShapeFrom body: PhyBody, size: Size, radius: Double) {
    let ptr = cpBoxShapeNew(body.handle, size.sizeX, size.sizeY, radius)

    self.init(fromHandle: ptr)
  }

  public convenience init(boxShapeFrom body: PhyBody, box: PhyBoundingBox, radius: Double) {
    let ptr = cpBoxShapeNew2(body.handle, box.handle, radius)

    self.init(fromHandle: ptr)
  }

//  deinit {
//    cpShapeSetUserData(self.handle, nil)
//    cpShapeFree(self.handle)
//  }

  public var friction: Double {
    get {
      return cpShapeGetFriction(self.handle)
    }
    set {
      cpShapeSetFriction(self.handle, newValue)
    }
  }

  public var elasticity: Double {
    get {
      return cpShapeGetElasticity(self.handle)
    }
    set {
      cpShapeSetElasticity(self.handle, newValue)
    }
  }

  public var collisionType: UInt {
    get {
      return cpShapeGetCollisionType(self.handle)
    }
    set {
      cpShapeSetCollisionType(self.handle, newValue)
    }
  }
}
