public enum SDLError : ErrorType {
  case InitialisationError(message: String)
  case MixerOpenError(message: String)
  case WindowCreationError(message: String)
  case RendererCreationError(message: String)
  case MediaLoadError(message: String)
  case ConvertSurfaceError(message: String)
  case RenderCopyError(message: String)
  case BadHandleError(message: String)
  case FailedUpdatePropertyError(message: String)
  case UnknownError(message: String)

  public var description: String {
    switch self {
    case .InitialisationError(let msg): return "Initialization Failed: \(msg)"
    case .MixerOpenError(let msg): return "Failed to open audio device: \(msg)"
    case .WindowCreationError(let msg): return "Window Creation Failed: \(msg)"
    case .RendererCreationError(let msg): return "Renderer Creation Failed: \(msg)"
    case .MediaLoadError(let msg): return "Media Load Failed: \(msg)"
    case .ConvertSurfaceError(let msg): return "Convert Surface Failed: \(msg)"
    case .RenderCopyError(let msg): return "Renderer Copy Failed: \(msg)"
    case .BadHandleError(let msg): return "Given a bad handle: \(msg)"
    case .FailedUpdatePropertyError(let msg): return "Failed to update property: \(msg)"
    case .UnknownError(let msg): return "Unknown Error: \(msg)"
    }
  }
}
