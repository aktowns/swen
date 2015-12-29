//
//   ScanCode.swift created on 29/12/15
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

public enum ScanCode: UInt32 {
  case ScanCodeUnknown = 0
  case ScanCodeA = 4
  case ScanCodeB
  case ScanCodeC
  case ScanCodeD
  case ScanCodeE
  case ScanCodeF
  case ScanCodeG
  case ScanCodeH
  case ScanCodeI
  case ScanCodeJ
  case ScanCodeK
  case ScanCodeL
  case ScanCodeM
  case ScanCodeN
  case ScanCodeO
  case ScanCodeP
  case ScanCodeQ
  case ScanCodeR
  case ScanCodeS
  case ScanCodeT
  case ScanCodeU
  case ScanCodeV
  case ScanCodeW
  case ScanCodeX
  case ScanCodeY
  case ScanCodeZ

  case ScanCode1 = 30
  case ScanCode2
  case ScanCode3
  case ScanCode4
  case ScanCode5
  case ScanCode6
  case ScanCode7
  case ScanCode8
  case ScanCode9
  case ScanCode0

  case ScanCodeReturn = 40
  case ScanCodeEscape
  case ScanCodeBackspace
  case ScanCodeTab
  case ScanCodeSpace

  case ScanCodeMinus = 45
  case ScanCodeEquals
  case ScanCodeLeftBracket
  case ScanCodeRightBracket
  case ScanCodeBackslash
  case ScanCodeNonUSHash
  case ScanCodeSemicolon
  case ScanCodeApostrophe
  case ScanCodeGrave
  case ScanCodeComma
  case ScanCodePeriod
  case ScanCodeSlash

  case ScanCodeCapsLock = 57

  case ScanCodeF1 = 58
  case ScanCodeF2
  case ScanCodeF3
  case ScanCodeF4
  case ScanCodeF5
  case ScanCodeF6
  case ScanCodeF7
  case ScanCodeF8
  case ScanCodeF9
  case ScanCodeF10
  case ScanCodeF11
  case ScanCodeF12

  case ScanCodePrintScreen = 70
  case ScanCodeScrollLock
  case ScanCodePause
  case ScanCodeInsert
  case ScanCodeHome
  case ScanCodePageUp
  case ScanCodeDelete
  case ScanCodeEnd
  case ScanCodePageDown
  case ScanCodeRight
  case ScanCodeLeft
  case ScanCodeDown
  case ScanCodeUp

  case ScanCodeNumLockClear = 83

  case ScanCodeKpDivide = 84
  case ScanCodeKpMultiply
  case ScanCodeKpMinus
  case ScanCodeKpPlus
  case ScanCodeKpEnter
  case ScanCodeKp1
  case ScanCodeKp2
  case ScanCodeKp3
  case ScanCodeKp4
  case ScanCodeKp5
  case ScanCodeKp6
  case ScanCodeKp7
  case ScanCodeKp8
  case ScanCodeKp9
  case ScanCodeKp0
  case ScanCodeKpPeriod

  case ScanCodeNonUSBackslash = 100
  case ScanCodeApplication
  case ScanCodePower
  case ScanCodeKpEquals
  case ScanCodeF13
  case ScanCodeF14
  case ScanCodeF15
  case ScanCodeF16
  case ScanCodeF17
  case ScanCodeF18
  case ScanCodeF19
  case ScanCodeF20
  case ScanCodeF21
  case ScanCodeF22
  case ScanCodeF23
  case ScanCodeF24
  case ScanCodeExecute
  case ScanCodeHelp
  case ScanCodeMenu
  case ScanCodeSelect
  case ScanCodeStop
  case ScanCodeAgain
  case ScanCodeUndo
  case ScanCodeCut
  case ScanCodeCopy
  case ScanCodePaste
  case ScanCodeFind
  case ScanCodeMute
  case ScanCodeVolumeUp
  case ScanCodeVolumeDown

  case ScanCodeLockingCapsLock = 130
  case ScanCodeLockingNumLock
  case ScanCodeLockingScrollLock

  case ScanCodeKpComma = 133
  case ScanCodeKpEqualsAs400

  case ScanCodeInternational1 = 135
  case ScanCodeInternational2
  case ScanCodeInternational3
  case ScanCodeInternational4
  case ScanCodeInternational5
  case ScanCodeInternational6
  case ScanCodeInternational7
  case ScanCodeInternational8
  case ScanCodeInternational9

  case ScanCodeLang1 = 144
  case ScanCodeLang2
  case ScanCodeLang3
  case ScanCodeLang4
  case ScanCodeLang5
  case ScanCodeLang6
  case ScanCodeLang7
  case ScanCodeLang8
  case ScanCodeLang9

  case ScanCodeAltErase = 153
  case ScanCodeSysReq
  case ScanCodeCancel
  case ScanCodeClear
  case ScanCodePrior
  case ScanCodeReturn2
  case ScanCodeSeperator
  case ScanCodeOut
  case ScanCodeOper
  case ScanCodeClearAgain
  case ScanCodeCrSel
  case ScanCodeExSel

  case ScanCodeKp00 = 176
  case ScanCodeKp000
  case ScanCodeThousandSeperator
  case ScanCodeDecimalSeperator
  case ScanCodeCurrencyUnit
  case ScanCodeCurrencySubUnit
  case ScanCodeKpLeftParen
  case ScanCodeKpRightParen
  case ScanCodeKpLeftBrace
  case ScanCodeKpRightBrace
  case ScanCodeKpTab
  case ScanCodeKpBackspace
  case ScanCodeKpA
  case ScanCodeKpB
  case ScanCodeKpC
  case ScanCodeKpD
  case ScanCodeKpE
  case ScanCodeKpF
  case ScanCodeKpXOR
  case ScanCodeKpPower
  case ScanCodeKpPercent
  case ScanCodeKpLess
  case ScanCodeKpGreater
  case ScanCodeKpAmpersand
  case ScanCodeKpDblAmpersand
  case ScanCodeKpVerticalBar
  case ScanCodeKpDblVerticalBar
  case ScanCodeKpColon
  case ScanCodeKpHash
  case ScanCodeKpSpace
  case ScanCodeKpAt
  case ScanCodeKpExClam
  case ScanCodeKpMemStore
  case ScanCodeKpMemRecall
  case ScanCodeKpMemClear
  case ScanCodeKpMemAdd
  case ScanCodeKpMemSubtract
  case ScanCodeKpMemMultiply
  case ScanCodeKpMemDivide
  case ScanCodeKpPlusMinus
  case ScanCodeKpClear
  case ScanCodeKpClearEntry
  case ScanCodeKpBinary
  case ScanCodeKpOctal
  case ScanCodeKpDecimal
  case ScanCodeKpHexadecimal

  case ScanCodeLCtrl = 224
  case ScanCodeLShift
  case ScanCodeLAlt
  case ScanCodeLGUI
  case ScanCodeRCtrl
  case ScanCodeRShift
  case ScanCodeRAlt
  case ScanCodeRGUI

  case ScanCodeMode = 257

  case ScanCodeAudioNext = 258
  case ScanCodeAudioPrev
  case ScanCodeAudioStop
  case ScanCodeAudioPlay
  case ScanCodeAudioMute
  case ScanCodeMediaSelect
  case ScanCodeWWW
  case ScanCodeMail
  case ScanCodeCalculator
  case ScanCodeComputer
  case ScanCodeACSearch
  case ScanCodeACHome
  case ScanCodeACBack
  case ScanCodeACForward
  case ScanCodeACStop
  case ScanCodeACRefresh
  case ScanCodeACBookmarks

  case ScanCodeBrightnessDown = 275
  case ScanCodeBrightnessUp
  case ScanCodeDisplaySwitch
  case ScanCodeKBDillumToggle
  case ScanCodeKBDillumDown
  case ScanCodeKBDillumUp
  case ScanCodeEject
  case ScanCodeSleep

  case ScanCodeApp1 = 283
  case ScanCodeApp2

  public init?(fromName name: String) {
    self.init(rawValue: SDL_GetScancodeFromName(name).rawValue)
  }

  public init?(fromKeyCode keycode: KeyCode) {
    self.init(rawValue: SDL_GetScancodeFromKey(SDL_Keycode(keycode.rawValue)).rawValue)
  }

  public var name: String? {
    return String.fromCString(SDL_GetScancodeName(SDL_Scancode(self.rawValue)))
  }
}
