public enum SDLError : ErrorType {
  case UnexpectedNullPointer(message: String)
  case InitialisationError(message: String)
  case MixerOpenError(message: String)
  case ConvertSurfaceError(message: String)
  case UnknownError(message: String)

  public var description: String {
    switch self {
    case .UnexpectedNullPointer(let msg): return "SDL returned a null pointer: \(msg)"
    case .InitialisationError(let msg): return "Initialization Failed: \(msg)"
    case .MixerOpenError(let msg): return "Failed to open audio device: \(msg)"
    case .ConvertSurfaceError(let msg): return "Convert Surface Failed: \(msg)"
    case .UnknownError(let msg): return "Unknown Error: \(msg)"
    }
  }
}
