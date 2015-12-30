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

public class PhyShape {
  let handle: COpaquePointer

  public init(fromHandle handle: COpaquePointer) {
    self.handle = handle

    assert(handle != nil, "PhyShape.init(fromHandle:) handed a null handle")
  }

  public convenience init(segmentedShapeFrom body: PhyBody, a: Vector<Double>, b: Vector<Double>, radius: Double) {
    let ptr = cpSegmentShapeNew(body.handle, cpVect.fromVector(a), cpVect.fromVector(b), radius)

    self.init(fromHandle: ptr)
  }

  public convenience init(circleShapeFrom body: PhyBody, radius: Double, offset: Vector<Double>) {
    let ptr = cpCircleShapeNew(body.handle, radius, cpVect.fromVector(offset))

    self.init(fromHandle: ptr)
  }

//  deinit {
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

}