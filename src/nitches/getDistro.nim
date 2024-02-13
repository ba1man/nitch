import std/xmlparser, std/xmltree
import std/strformat
import std/strutils

proc getDistro*(): string =
  let filepath = "/System/Library/CoreServices/SystemVersion.plist"
  let tree = loadXml(filepath)
  var valueArray: array[10, string]
  var i = 0
  for item in tree.findAll("string"):
    valueArray[i] = $(innerText(item))
    i += 1
  var productName = valueArray[3]
  let productVersion = valueArray[4]
  if productVersion.startsWith("13"):
    productName = &"{productName} Ventura"
  elif productVersion.startsWith("14"):
    productName = &"{productName} Sonoma"
  result = productName