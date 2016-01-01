//
//   PhyBoundingBox.swift created on 2/01/16
//   Swen project 
//   
//   Copyright 2016 Ashley Towns <code@ashleytowns.id.au>
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

public class PhyBoundingBox {
  public let handle: cpBB

  public init(fromHandle handle: cpBB) {
    self.handle = handle
  }

  public convenience init(topLeft: Vector, bottomRight: Vector) {
    let bb = cpBBNew(topLeft.x, bottomRight.y, bottomRight.x, topLeft.y)

    self.init(fromHandle: bb)
  }

  public convenience init(p: Vector, r: Double) {
    let bb = cpBBNewForCircle(cpVect.fromVector(p), r)

    self.init(fromHandle: bb)
  }

  public func intersects(b: PhyBoundingBox) -> Bool {
    return cpBBIntersects(self.handle, b.handle) == PhyMisc.cpTrue
  }

  public func contains(b: PhyBoundingBox) -> Bool {
    return cpBBContainsBB(self.handle, b.handle) == PhyMisc.cpTrue
  }

  public func merge(b: PhyBoundingBox) -> PhyBoundingBox {
    return PhyBoundingBox(fromHandle: cpBBMerge(self.handle, b.handle))
  }

  public var center: Vector {
    return cpBBCenter(self.handle).toVector()
  }

  public var area: Double {
    return cpBBArea(self.handle)
  }
}