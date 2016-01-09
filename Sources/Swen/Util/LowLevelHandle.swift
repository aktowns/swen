//
//   LowLevelHandle.swift created on 3/01/16
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

public protocol LowLevelHandle {
  typealias RawHandle : Hashable
  var handle: RawHandle { get }

  init(fromHandle: RawHandle)
}

public protocol LowLevelMemoizedHandle: LowLevelHandle {
  static func fromHandle(handle: RawHandle) -> Self

  static var memoized: [RawHandle: Self] { get set }
}
