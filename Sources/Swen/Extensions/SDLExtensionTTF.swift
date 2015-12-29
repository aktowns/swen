//
//   SDLExtensionTTF.swift created on 28/12/15
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

public class SDLExtensionTTF : SDLExtension {
  public func prepare() throws {
    if TTF_Init() < 0 {
      throw SDLError.InitialisationError(message: "TTF_Init: \(SDL.getErrorMessage())")
    }
  }

  public func quit() {
    TTF_Quit()
  }
}