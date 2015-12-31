import PackageDescription

let package = Package(
  name: "Swen",
  dependencies: [
    .Package(url: "https://github.com/aktowns/CSDL.git", Version(1,0,0)),
    .Package(url: "https://github.com/aktowns/CXML2.git", Version(1,0,0)),
    .Package(url: "../CChipmunk2D/.git", Version(1,0,0)),
    .Package(url: "https://github.com/devxoul/Then", "0.3.1"),
    .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 1),
  ],
  targets: [
    Target(
      name: "SwenDemo",
      dependencies: [.Target(name: "Swen")])
  ])
