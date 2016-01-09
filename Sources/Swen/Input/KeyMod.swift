//
//   KeyMod.swift created on 29/12/15
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

import CSDL

public struct KeyMod: OptionSetType {
  public let rawValue: UInt16

  public init(rawValue: UInt16) {
    self.rawValue = rawValue
  }

  public init(rawValue: UInt32) {
    self.rawValue = UInt16(rawValue)
  }

  static let None = KeyMod(rawValue: KMOD_NONE.rawValue)
  static let LShift = KeyMod(rawValue: KMOD_LSHIFT.rawValue)
  static let RShift = KeyMod(rawValue: KMOD_RSHIFT.rawValue)
  static let LCtrl = KeyMod(rawValue: KMOD_LCTRL.rawValue)
  static let RCtrl = KeyMod(rawValue: KMOD_RCTRL.rawValue)
  static let LAlt = KeyMod(rawValue: KMOD_LALT.rawValue)
  static let RAlt = KeyMod(rawValue: KMOD_RALT.rawValue)
  static let LGUI = KeyMod(rawValue: KMOD_LGUI.rawValue)
  static let RGUI = KeyMod(rawValue: KMOD_RGUI.rawValue)
  static let NUM = KeyMod(rawValue: KMOD_NUM.rawValue)
  static let CAPS = KeyMod(rawValue: KMOD_CAPS.rawValue)
  static let MODE = KeyMod(rawValue: KMOD_MODE.rawValue)
  static let RESERVED = KeyMod(rawValue: KMOD_RESERVED.rawValue)

  public var ctrl: Bool {
    return self.contains(KeyMod.LCtrl) || self.contains(KeyMod.RCtrl)
  }
  public var shift: Bool {
    return self.contains(KeyMod.LShift) || self.contains(KeyMod.RShift)
  }
  public var alt: Bool {
    return self.contains(KeyMod.LAlt) || self.contains(KeyMod.RAlt)
  }
  public var gui: Bool {
    return self.contains(KeyMod.LGUI) || self.contains(KeyMod.RGUI)
  }
}
