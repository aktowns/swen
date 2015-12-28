extension Array {
  public func findFirst(fn: (Element) throws -> Bool) rethrows -> Element? {
    let index = try self.indexOf { element in
      try fn(element)
    }
    return index.flatMap{self[$0]}
  }
}