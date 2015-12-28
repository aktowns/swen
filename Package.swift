import PackageDescription

let package = Package(
  name: "Swen",
  dependencies: [
    .Package(url: "../CSDL/.git", Version(1,0,0))
  ])
