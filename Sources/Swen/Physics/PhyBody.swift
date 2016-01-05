//
//   PhyBody.swift created on 30/12/15
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

public final class PhyBody : LowLevelMemoizedHandle {
  public let handle: COpaquePointer
  public static var memoized: [COpaquePointer: PhyBody] = Dictionary<COpaquePointer, PhyBody>()

  public var positionChangedListeners: Array<(body: PhyBody) -> ()> = []

  public required init(fromHandle handle: COpaquePointer) {
    self.handle = handle

    assert(handle != nil, "PhyBody.init(fromHandle:) handed a null handle")

    assert(PhyBody.memoized[handle] == nil, "PhyBody.init(fromHandle:) initialised with tagged handler")

    cpBodySetUserData(self.handle, unsafeBitCast(self, UnsafeMutablePointer<Void>.self))
    cpBodySetPositionUpdateFunc(self.handle, {
      (body: COpaquePointer, dt: Double) in
      cpBodyUpdatePosition(body, dt)

      let ud = cpBodyGetUserData(body)
      let klass = unsafeBitCast(ud, PhyBody.self)

      klass.firePositionChangedListeners()
    })

    PhyBody.memoized[handle] = self
  }

  private func firePositionChangedListeners() {
    for listener in positionChangedListeners {
      listener(body: self)
    }
  }

  // try UserData falling back to creating a new instance
  public static func fromHandle(handle: COpaquePointer) -> PhyBody {
    let mptr = PhyBody.memoized[handle]

    if let ptr = mptr {
      return ptr
    }

    return PhyBody(fromHandle: handle)
  }

  public convenience init(mass: Double, moment: Double) {
    let ptr = cpBodyNew(mass, moment)

    self.init(fromHandle: ptr)
  }

  public var position: Vector {
    get {
      return cpBodyGetPosition(self.handle).toVector()
    }
    set {
      cpBodySetPosition(self.handle, cpVect.fromVector(newValue))
    }
  }

  public var velocity: Vector {
    get {
      return cpBodyGetVelocity(self.handle).toVector()
    }
    set {
      cpBodySetVelocity(self.handle, cpVect.fromVector(newValue))
    }
  }
}
