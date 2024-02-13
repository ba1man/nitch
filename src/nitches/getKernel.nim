import std/[
  osproc, 
  strutils
]

proc getKernel*(): string =
  result = strip(execProcess("uname -r"))
