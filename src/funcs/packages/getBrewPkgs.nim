import std/[strutils, osproc, sequtils, os]

proc getBrewPkgs*(): string =
  var paths: array[2, string]
  paths[0] = strip(execProcess("brew --cellar"))
  paths[1] = strip(execProcess("brew --caskroom"))
  var cnt = 0
  for path in paths:
    let files: seq[tuple] = path.walkDir(relative = true).toSeq
    cnt += files.len - 1
  result = $(cnt)