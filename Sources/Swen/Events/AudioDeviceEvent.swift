import CSDL

// Uint32 type;        /**< ::SDL_AUDIODEVICEADDED, or ::SDL_AUDIODEVICEREMOVED */
// Uint32 timestamp;
// Uint32 which;       /**< The audio device index for the ADDED event (valid until
//                          next SDL_GetNumAudioDevices() call), SDL_AudioDeviceID for the REMOVED event */
// Uint8 iscapture;    /**< zero if an output device, non-zero if a capture device. */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;

public class AudioDeviceEvent : CommonEvent {
  private var adeviceEvent: SDL_AudioDeviceEvent { return self.handle.adevice }

  public var which: UInt32 { return adeviceEvent.which }
  public var iscapture: UInt8 { return adeviceEvent.iscapture }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), timestamp:\(timestamp), which:\(which) " +
        "iscapture:\(iscapture))"
  }
}