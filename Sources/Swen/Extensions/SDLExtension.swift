public protocol SDLExtension {
  func prepare() throws -> Void
  func start() throws -> Void
  func quit() -> Void
}