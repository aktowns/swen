import CSDL

public struct ImageInitFlags : OptionSetType {
  public let rawValue: Int32

  public init(rawValue: Int32) {
    self.rawValue = rawValue
  }

  public init(rawValue: UInt32) {
    self.rawValue = Int32(rawValue)
  }

  static let JPG  = ImageInitFlags(rawValue: IMG_INIT_JPG.rawValue)
  static let PNG  = ImageInitFlags(rawValue: IMG_INIT_PNG.rawValue)
  static let TIF  = ImageInitFlags(rawValue: IMG_INIT_TIF.rawValue)
  static let WEBP = ImageInitFlags(rawValue: IMG_INIT_WEBP.rawValue)
}

public class SDLExtensionImage : SDLExtension {
  let flags: ImageInitFlags
  let defaultFlags: ImageInitFlags = [ImageInitFlags.JPG,
                                      ImageInitFlags.PNG,
                                      ImageInitFlags.TIF,
                                      ImageInitFlags.WEBP]

  init() {
    self.flags = defaultFlags
  }

  init(flags: ImageInitFlags) {
    self.flags = defaultFlags
  }

  public func prepare() {
    let initialised = ImageInitFlags(rawValue: IMG_Init(flags.rawValue))
    let failedToLoad = flags.subtract(initialised)

    if failedToLoad.contains(ImageInitFlags.PNG) {
      print("Warning: Failed to load PNG image support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(ImageInitFlags.JPG) {
      print("Warning: Failed to load JPG image support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(ImageInitFlags.TIF) {
      print("Warning: failed to load TIF image support: \(SDL.getErrorMessage())")
    }

    if failedToLoad.contains(ImageInitFlags.WEBP) {
      print("Warning: failed to load WEBP image support: \(SDL.getErrorMessage())")
    }
  }

  public func quit() {
    IMG_Quit()
  }
}