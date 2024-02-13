import std/strutils
import std/osproc
import std/strformat

proc getRam*(): string =
  let sysinfo = strip(execProcess("sysctl -n hw.pagesize hw.memsize vm.page_pageable_internal_count vm.page_purgeable_count"))
  let vminfo = strip(execProcess("vm_stat"))
  let sp = sysinfo.split("\n")

  let hw_pagesize = sp[0].parseUInt
  let mem_total = sp[1].parseFloat / 1024 / 1024
  let pages_app = sp[2].parseUInt - sp[3].parseUInt
  let i0 = find(vminfo, "wired down:") + 11
  let i1 = find(vminfo, ".", i0) - 1
  let pages_wired = strip(vminfo.substr(i0, i1)).parseUInt

  let i2 = find(vminfo, "occupied by compressor:") + 23
  let i3 = find(vminfo, ".", i2) - 1
  var pages_compressed = strip(vminfo.substr(i2, i3)).parseUInt
  let mem_used = float((pages_app + pages_wired + pages_compressed) * hw_pagesize) / 1024 / 1024
  let mem_label = "MiB"
  result = &"{int(mem_used)}{mem_label} / {int(mem_total)}{mem_label}"


proc getRam_MB*(): string =
  let
    fileSeq: seq[string] = "/proc/meminfo".readLines(3)
  
  let
    memTotalString = fileSeq[0].split(" ")[^2]
    memAvailableString = fileSeq[2].split(" ")[^2]

    memTotalInt = memTotalString.parseUInt div 1000
    memAvailableInt = memAvailableString.parseUInt div 1000

    memUsedInt = memTotalInt - memAvailableInt

  result = $(memUsedInt) & " | " & $(memTotalInt) & " MB"
