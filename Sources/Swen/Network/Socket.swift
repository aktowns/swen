import Foundation
import CSDL

public class Socket {
  public class func resolve(ipAddress addr: IPAddress) -> String? {
    var addr = IPaddress.fromIPAddress(addr)
    let resv = SDLNet_ResolveIP(&addr)
    return String.fromCString(resv)
  }
}
