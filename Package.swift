import PackageDescription

let package = Package(
  name: "Swen",
  dependencies: [
    .Package(url: "https://github.com/aktowns/CSDL.git", Version(1,0,0)),
    .Package(url: "https://github.com/aktowns/CXML2.git", Version(1,0,0)),
    .Package(url: "https://github.com/aktowns/CChipmunk2D.git", Version(1,0,0))
  ],
  targets: [
    Target(
      name: "SwenDemo",
      dependencies: [.Target(name: "Swen")])
  ])
