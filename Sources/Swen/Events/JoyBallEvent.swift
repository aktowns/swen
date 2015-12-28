import CSDL

// Uint32 type;        /**< ::SDL_JOYBALLMOTION */
// Uint32 timestamp;
// SDL_JoystickID which; /**< The joystick instance id */
// Uint8 ball;         /**< The joystick trackball index */
// Uint8 padding1;
// Uint8 padding2;
// Uint8 padding3;
// Sint16 xrel;        /**< The relative motion in the X direction */
// Sint16 yrel;        /**< The relative motion in the Y direction */

public class JoyBallEvent : CommonEvent {
  private var jballEvent: SDL_JoyBallEvent { return self.handle.jball }

  public var which: SDL_JoystickID { return jballEvent.which }
  public var ball: UInt8 { return jballEvent.ball }
  public var motion: Point<Int16> { return Point<Int16>(x: jballEvent.xrel, y: jballEvent.yrel) }

  public override var description : String {
    return "#\(self.dynamicType)(handle:\(handle), type:\(type), timestamp:\(timestamp), which:\(which), " +
        "ball:\(ball), motion:\(motion))"
  }
}