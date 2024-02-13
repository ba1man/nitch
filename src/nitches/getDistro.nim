import std/[
  strformat
]

proc getDistro*(productName: string, productVersion: string): string =
  result = &"{productName} {productVersion}"