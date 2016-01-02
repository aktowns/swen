//
//   ChipmunkConvertHelper.swift created on 30/12/15
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

extension cpVect {
  static func fromVector(vect: Vector) -> cpVect {
    return cpVect(x: vect.x, y: vect.y)
  }

  func toVector() -> Vector {
    return Vector(x: self.x, y: self.y)
  }
}

extension cpSpaceDebugColor {
  static func fromColour(colour: Colour) -> cpSpaceDebugColor {
    return cpSpaceDebugColor(r: Float(colour.r), g: Float(colour.g), b: Float(colour.b), a: Float(colour.a ?? 0))
  }

  func toColour() -> Colour {
    return Colour(r: UInt8(self.r), g: UInt8(self.g), b: UInt8(self.b), a: UInt8(self.a))
  }
}
