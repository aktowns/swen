import CSDL

extension SDL_Rect {
  static func fromRect(rect: Rect<Int32>) -> SDL_Rect {
    return SDL_Rect(x: rect.x, y: rect.y, w: rect.sizeX, h: rect.sizeY)
  }
}

extension SDL_Point {
  static func fromPoint(point: Point<Int32>) -> SDL_Point {
    return SDL_Point(x: point.x, y: point.y)
  }
}

extension SDL_Color {
  static func fromColour(colour: Colour) -> SDL_Color {
    return SDL_Color(r: colour.r, g: colour.g, b: colour.b, a: colour.a ?? 0)
  }
}

extension IPaddress {
  static func fromIPAddress(ipaddr: IPAddress) -> IPaddress {
    return IPaddress(host: ipaddr.host, port: ipaddr.port)
  }
}