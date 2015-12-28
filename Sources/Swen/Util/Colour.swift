public struct Colour {
  var r: UInt8
  var g: UInt8
  var b: UInt8
  var a: UInt8?

  static var black: Colour {
    return Colour(r: 0x00, g: 0x00, b: 0x00, a: 0x00)
  }

  static var white: Colour {
    return Colour(r: 0xFF, g: 0xFF, b: 0xFF, a: 0x00)
  }
}