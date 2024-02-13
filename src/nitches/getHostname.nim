import std/osproc
import std/strutils

proc getHostname*(): string =
  result = strip(execProcess("hostname"))
