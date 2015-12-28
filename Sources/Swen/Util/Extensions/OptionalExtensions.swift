import Foundation

extension Optional {
  public func join(opt: Wrapped?) -> Wrapped? {
    return try! self.flatMap { $0 }
  }

  func toPointer() -> UnsafeMutablePointer<Wrapped> {
    var ptr = UnsafeMutablePointer<Wrapped>.alloc(1)

    if let obj = self {
      ptr.initialize(obj)
    } else {
      ptr = nil
    }

    return ptr
  }
}