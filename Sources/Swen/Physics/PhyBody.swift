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
import Signals

public final class PhyBody: LowLevelMemoizedHandle {
  public let handle: COpaquePointer
  public static var memoized: [COpaquePointer: PhyBody] = Dictionary<COpaquePointer, PhyBody>()

  let onPositionChanged = Signal<Vector>()
  let onVelocityChanged = Signal<Vector>()

  public typealias PositionUpdateFunc = (body: PhyBody, dt: Double) -> Void
  public typealias VelocityUpdateFunc = (body: PhyBody, gravity: Vector, damping: Double, dt: Double) -> Void

  private var _velocityUpdateFunc: VelocityUpdateFunc
  private var _positionUpdateFunc: PositionUpdateFunc

  public required init(fromHandle handle: COpaquePointer) {
    self.handle = handle

    assert(handle != nil, "PhyBody.init(fromHandle:) handed a null handle")

    assert(PhyBody.memoized[handle] == nil, "PhyBody.init(fromHandle:) initialised with tagged handler")

    // default update funcs just call the underlying updates
    self._positionUpdateFunc = PhyBody.defaultPositionUpdateFunc
    self._velocityUpdateFunc = PhyBody.defaultVelocityUpdateFunc

    setPositionUpdateFunc(PhyBody.defaultPositionUpdateFunc)
    setVelocityUpdateFunc(PhyBody.defaultVelocityUpdateFunc)

    PhyBody.memoized[handle] = self
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

  public static var defaultVelocityUpdateFunc: VelocityUpdateFunc {
    get {
      return {
        (body: PhyBody, gravity: Vector, damping: Double, dt: Double) in
        cpBodyUpdateVelocity(body.handle, cpVect.fromVector(gravity), damping, dt)
      }
    }
  }

  public static var defaultPositionUpdateFunc: PositionUpdateFunc {
    get {
      return {
        (body: PhyBody, dt: Double) in
        cpBodyUpdatePosition(body.handle, dt)
      }
    }
  }

  // WARN: this isn't re-entrant!!!!!
  public func setVelocityUpdateFunc(f: VelocityUpdateFunc) {
    self._velocityUpdateFunc = f
    cpBodySetUserData(self.handle, unsafeBitCast(self, UnsafeMutablePointer<Void>.self))

    cpBodySetVelocityUpdateFunc(self.handle, {
      (body: COpaquePointer, gravity: cpVect, damping: Double, dt: Double) in

      let ud = cpBodyGetUserData(body)
      let klass = unsafeBitCast(ud, PhyBody.self)

      klass._velocityUpdateFunc(body: klass, gravity: gravity.toVector(), damping: damping, dt: dt)

      klass.onVelocityChanged => klass.velocity
    })
  }

  // WARN: this isn't re-entrant!!!!!
  public func setPositionUpdateFunc(f: PositionUpdateFunc) {
    self._positionUpdateFunc = f
    cpBodySetUserData(self.handle, unsafeBitCast(self, UnsafeMutablePointer<Void>.self))

    cpBodySetPositionUpdateFunc(self.handle, {
      (body: COpaquePointer, dt: Double) in

      let ud = cpBodyGetUserData(body)
      let klass = unsafeBitCast(ud, PhyBody.self)

      klass._positionUpdateFunc(body: klass, dt: dt)

      klass.onPositionChanged => klass.position
    })
  }

}
