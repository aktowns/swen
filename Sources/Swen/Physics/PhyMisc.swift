//
//   PhyMisc.swift created on 30/12/15
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

public class PhyMisc {
  public static func momentForCircle(m m: Double, r1: Double, r2: Double, offset: Vector) -> Double {
    return cpMomentForCircle(m, r1, r2, cpVect.fromVector(offset))
  }

  public static func momentForSegment(m m: Double, a: Vector, b: Vector, radius: Double) -> Double {
    return cpMomentForSegment(m, cpVect.fromVector(a), cpVect.fromVector(b), radius)
  }

  public static func momentForBox(m m: Double, width: Double, height: Double) -> Double {
    return cpMomentForBox(m, width, height)
  }

  public static var versionString: String {
    return String.fromCString(cpVersionString)!
  }

}
