import std/[
  osproc,
  strutils
]

proc getHostname*(): string =
  result = strip(execProcess("hostname"))
