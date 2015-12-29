import CSDL

public struct KeyMod : OptionSetType {
  public let rawValue: UInt16

  public init(rawValue: UInt16) {
    self.rawValue = rawValue
  }

  public init(rawValue: UInt32) {
    self.rawValue = UInt16(rawValue)
  }

  static let None     = KeyMod(rawValue: KMOD_NONE.rawValue)
  static let LShift   = KeyMod(rawValue: KMOD_LSHIFT.rawValue)
  static let RShift   = KeyMod(rawValue: KMOD_RSHIFT.rawValue)
  static let LCtrl    = KeyMod(rawValue: KMOD_LCTRL.rawValue)
  static let RCtrl    = KeyMod(rawValue: KMOD_RCTRL.rawValue)
  static let LAlt     = KeyMod(rawValue: KMOD_LALT.rawValue)
  static let RAlt     = KeyMod(rawValue: KMOD_RALT.rawValue)
  static let LGUI     = KeyMod(rawValue: KMOD_LGUI.rawValue)
  static let RGUI     = KeyMod(rawValue: KMOD_RGUI.rawValue)
  static let NUM      = KeyMod(rawValue: KMOD_NUM.rawValue)
  static let CAPS     = KeyMod(rawValue: KMOD_CAPS.rawValue)
  static let MODE     = KeyMod(rawValue: KMOD_MODE.rawValue)
  static let RESERVED = KeyMod(rawValue: KMOD_RESERVED.rawValue)

  public var Ctrl: Bool {
    return self.contains(KeyMod.LCtrl) || self.contains(KeyMod.RCtrl)
  }
  public var Shift: Bool {
    return self.contains(KeyMod.LShift) || self.contains(KeyMod.RShift)
  }
  public var Alt: Bool {
    return self.contains(KeyMod.LAlt) || self.contains(KeyMod.RAlt)
  }
  public var GUI: Bool {
    return self.contains(KeyMod.LGUI) || self.contains(KeyMod.RGUI)
  }
}
