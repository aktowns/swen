//
//   XPathDocument.swift created on 29/12/15
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

/*
   This is a light wrapper around libxml2 to read xml based formats
   this is being used mainly because NSXML lacks linux support at the moment.

   This is really crude and only does what i need it to..
*/

import CXML2

enum XMLElementType : UInt32 {
  case ElementNode      = 1
  case AttributeNode    = 2
  case TextNode         = 3
  case CDATASectionNode = 4
  case EntityRefNode    = 5
  case EntityNode       = 6
  case PINode           = 7
  case CommentNode      = 8
  case DocumentNode     = 9
  case DocumentTypeNode = 10
  case DocumentFragNode = 11
  case NotationNode     = 12
  case HTMLDocumentNode = 13
  case DTDNode          = 14
  case ElementDecl      = 15
  case AttributeDecl    = 16
  case EntityDecl       = 17
  case NamespaceDecl    = 18
  case XIncludeStart    = 19
  case XIncludeEnd      = 20
}

public class XMLNode: CustomStringConvertible {
  let handle: xmlNodePtr

  public init(withHandle handle: xmlNodePtr) {
    self.handle = handle
  }

  public func getProp(property: String) -> String? {
    let prop = xmlGetProp(self.handle, property)
    return String.fromCString(UnsafePointer<Int8>(prop))
  }

  var type: XMLElementType? {
    return XMLElementType(rawValue: self.handle.memory.type.rawValue)
  }

  var name: String? {
    let convName = UnsafePointer<Int8>(self.handle.memory.name)
    return String.fromCString(convName)
  }

  var content: String? {
    let convContent = UnsafePointer<Int8>(self.handle.memory.content)
    return String.fromCString(convContent)
  }

  public var description: String {
    return "#\(self.dynamicType)(name:\(name), type:\(type), content:\(content))"
  }
}

public class XPathDocument {
  let doc: xmlDocPtr
  let ctx: xmlXPathContextPtr

  public init(withPath path: String) {
    let docptr = xmlParseFile(path)
    assert(docptr != nil, "xmlParseFile failed, returned a null pointer.")

    let ctxptr = xmlXPathNewContext(docptr)
    assert(ctxptr != nil, "xmlXPathNewContext failed, returned a null pointer.")

    self.doc = docptr
    self.ctx = ctxptr
  }

  public func search(withXPath xpath: String) -> [XMLNode] {
    let exprptr = xmlXPathEvalExpression(xpath, self.ctx)
    assert(exprptr != nil, "xmlXPathEvalExpression failed, returned a null pointer.")

    return getNodes(exprptr.memory.nodesetval)
  }

  private func getNodes(nodes: xmlNodeSetPtr) -> [XMLNode] {
    let size: Int = (nodes != nil) ? Int(nodes.memory.nodeNr) : Int(0)

    var outNodes = Array<XMLNode>()

    for i in Range(start: Int(0), end: size) {
      let node = XMLNode(withHandle: nodes.memory.nodeTab[i])
      outNodes.append(node)
    }

    return outNodes
  }
}
