public class SDLExtensionLoader {
  typealias extensionConstructor = () -> SDLExtension
  static var extensions: [extensionConstructor] = [
      SDLExtensionCore.init,
      SDLExtensionImage.init,
      SDLExtensionMixer.init,
      SDLExtensionNet.init,
      SDLExtensionTTF.init
  ]

  private static var loadedExtensions: [SDLExtension] = []

  public static func loadAll() throws {
    self.loadedExtensions = SDLExtensionLoader.extensions.map{$0()}
  }

  public static func prepareAll() throws {
    for ext in self.loadedExtensions {
      print("loading extension: \(ext)")

      try ext.prepare()
    }
  }

  public static func quitAll() {
    for ext in self.loadedExtensions {
      print("unloading extension: \(ext)")

      ext.quit()
    }
  }

}