import std/[
  strutils,
  xmlparser,
  xmltree
]

proc cacheSystemVersion*(): (string, string) =
  let filepath = "/System/Library/CoreServices/SystemVersion.plist"
  let tree = loadXml(filepath)
  var valueArray: array[10, string]
  var i = 0
  for item in tree.findAll("string"):
    valueArray[i] = $(innerText(item))
    i += 1
  let productVersion = valueArray[4]
  var codename = ""

  if productVersion.startsWith("10.4"):
    codename = "Mac OS X Tiger"
  elif productVersion.startsWith("10.5"):
    codename = "Mac OS X Leopard"
  elif productVersion.startsWith("10.6"):
    codename = "Mac OS X Snow Leopard"
  elif productVersion.startsWith("10.7"):
    codename = "Mac OS X Lion"
  elif productVersion.startsWith("10.8"):
    codename = "OS X Mountain Lion"
  elif productVersion.startsWith("10.9"):
    codename = "OS X Mavericks"
  elif productVersion.startsWith("10.10"):
    codename = "OS X Yosemite"
  elif productVersion.startsWith("10.11"):
    codename = "OS X El Capitan"
  elif productVersion.startsWith("10.12"):
    codename = "macOS Sierra"
  elif productVersion.startsWith("10.13"):
    codename = "macOS High Sierra"
  elif productVersion.startsWith("10.14"):
    codename = "macOS Mojave"
  elif productVersion.startsWith("10.15"):
    codename = "macOS Catalina"
  elif productVersion.startsWith("10.16"):
    codename = "macOS Big Sur"
  elif productVersion.startsWith("11"):
    codename = "macOS Big Sur"
  elif productVersion.startsWith("12"):
    codename = "macOS Monterey"
  elif productVersion.startsWith("13"):
    codename = "macOS Ventura"
  elif productVersion.startsWith("14"):
    codename = "macOS Sonoma"
  else:
    codename = "macOS"
  result = (codename, productVersion)
