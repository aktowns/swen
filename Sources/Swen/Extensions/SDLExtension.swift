public protocol SDLExtension {
  func prepare() throws -> Void
  func quit() -> Void
}