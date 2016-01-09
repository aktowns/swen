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

private final class FunctionPointerWrapper<T> {
  let fp: T

  init(f: T) {
    self.fp = f
  }
}

public final class PhyBody: LowLevelMemoizedHandle {
  public typealias RawHandle = UnsafeMutablePointer<cpBody>

  public let handle: RawHandle
  public static var memoized: [RawHandle: PhyBody] = Dictionary<RawHandle, PhyBody>()

  let onPositionChanged = Signal<Vector>()
  let onVelocityChanged = Signal<Vector>()

  public typealias ArbiterIterator = (PhyArbiter) -> Void
  public typealias ShapeIterator = (PhyShape) -> Void
  public typealias ConstraintIterator = (PhyConstraint) -> Void

  public typealias PositionUpdateFunc = (body: PhyBody, dt: Double) -> Void
  public typealias VelocityUpdateFunc = (body: PhyBody, gravity: Vector, damping: Double, dt: Double) -> Void

  private var _velocityUpdateFunc: VelocityUpdateFunc
  private var _positionUpdateFunc: PositionUpdateFunc

  public required init(fromHandle handle: RawHandle) {
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
  public static func fromHandle(handle: RawHandle) -> PhyBody {
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

  public var mass: Double {
    get {
      return cpBodyGetMass(self.handle)
    }
    set {
      cpBodySetMass(self.handle, newValue)
    }
  }

  public var space: PhySpace {
    get {
      return PhySpace.fromHandle(cpBodyGetSpace(self.handle))
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

  public func updateVelocity(gravity: Vector, damping: Double, dt: Double) {
    PhyBody.defaultVelocityUpdateFunc(body: self, gravity: gravity, damping: damping, dt: dt)
  }

  // WARN: this isn't re-entrant!!!!!
  public func setVelocityUpdateFunc(f: VelocityUpdateFunc) {
    self._velocityUpdateFunc = f
    cpBodySetUserData(self.handle, unsafeBitCast(self, UnsafeMutablePointer<Void>.self))

    cpBodySetVelocityUpdateFunc(self.handle, {
      (body: RawHandle, gravity: cpVect, damping: Double, dt: Double) in

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
      (body: RawHandle, dt: Double) in

      let ud = cpBodyGetUserData(body)
      let klass = unsafeBitCast(ud, PhyBody.self)

      klass._positionUpdateFunc(body: klass, dt: dt)

      klass.onPositionChanged => klass.position
    })
  }

  public func eachArbiter(f: ArbiterIterator) {
    // TODO: concerned about performance implications of this.
    let fp = FunctionPointerWrapper<ArbiterIterator>(f: f)
    let fptr = unsafeBitCast(fp, UnsafeMutablePointer<Void>.self)

    let iterator: cpBodyArbiterIteratorFunc = {
      (body: RawHandle, arb: PhyArbiter.RawHandle, me: UnsafeMutablePointer<Void>) in
      let f: FunctionPointerWrapper<ArbiterIterator> = unsafeBitCast(me, FunctionPointerWrapper<ArbiterIterator>.self)
      let arbiter = PhyArbiter.fromHandle(arb)

      f.fp(arbiter)
    }

    cpBodyEachArbiter(self.handle, iterator, fptr)
  }

  public func eachShape(f: ShapeIterator) {
    // TODO: concerned about performance implications of this.
    let fp = FunctionPointerWrapper<ShapeIterator>(f: f)
    let fptr = unsafeBitCast(fp, UnsafeMutablePointer<Void>.self)

    let iterator: cpBodyShapeIteratorFunc = {
        (body: RawHandle, shp: PhyShape.RawHandle, me: UnsafeMutablePointer<Void>) in
      let f: FunctionPointerWrapper<ShapeIterator> = unsafeBitCast(me, FunctionPointerWrapper<ShapeIterator>.self)
      let shape = PhyShape.fromHandle(shp)

      f.fp(shape)
    }

    cpBodyEachShape(self.handle, iterator, fptr)
  }

  public func eachConstraint(f: ConstraintIterator) {
    // TODO: concerned about performance implications of this.
    let fp = FunctionPointerWrapper<ConstraintIterator>(f: f)
    let fptr = unsafeBitCast(fp, UnsafeMutablePointer<Void>.self)

    let iterator: cpBodyConstraintIteratorFunc = {
      (body: RawHandle, constr: PhyConstraint.RawHandle, me: UnsafeMutablePointer<Void>) in
      let f = unsafeBitCast(me, FunctionPointerWrapper<ConstraintIterator>.self)
      let constraint = PhyConstraint.fromHandle(constr)

      f.fp(constraint)
    }

    cpBodyEachConstraint(self.handle, iterator, fptr)
  }
}
