import std/xmlparser, std/xmltree, std/lists
import std/strformat

proc getKernel*(): string =
  let filepath = "/System/Library/CoreServices/SystemVersion.plist"
  let tree = loadXml(filepath)
  var valueArray: array[10, string]
  var i = 0
  for item in tree.findAll("string"):
    valueArray[i] = $(innerText(item))
    i += 1
  let productName = valueArray[3]
  let productVersion = valueArray[4]
  result = productVersion
