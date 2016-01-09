//
//   PhyArbiter.swift created on 9/01/16
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

public final class PhyArbiter: LowLevelMemoizedHandle {
  public typealias RawHandle = UnsafeMutablePointer<cpArbiter>

  public let handle: RawHandle
  public static var memoized: [RawHandle:PhyArbiter] = Dictionary<RawHandle, PhyArbiter>()

  public required init(fromHandle handle: RawHandle) {
    self.handle = handle

    assert(handle != nil, "PhyArbiter.init(fromHandle:) handed a null handle")

    assert(PhyArbiter.memoized[handle] == nil, "PhyArbiter.init(fromHandle:) initialised with tagged handler")

    PhyArbiter.memoized[handle] = self
  }

  // try UserData falling back to creating a new instance
  public static func fromHandle(handle: RawHandle) -> PhyArbiter {
    let mptr = PhyArbiter.memoized[handle]

    if let ptr = mptr {
      return ptr
    }

    return PhyArbiter(fromHandle: handle)
  }

  public var normal: Vector {
    get {
      return cpArbiterGetNormal(self.handle).toVector()
    }
  }

}
