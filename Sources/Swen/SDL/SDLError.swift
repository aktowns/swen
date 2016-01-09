//
//   SDLError.swift created on 27/12/15
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

public enum SDLError: ErrorType {
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
