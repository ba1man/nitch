import std/[
  osproc,
  strutils,
  strformat
]

proc parseVMStat*(vminfo: string, key: string): string =
  let i0 = find(vminfo, key) + key.len + 1
  let i1 = find(vminfo, ".", i0) - 1
  result = strip(vminfo.substr(i0, i1))

proc getRam*(): string =
  let sysinfo = strip(execProcess("sysctl -n hw.pagesize hw.memsize vm.page_pageable_internal_count vm.page_purgeable_count")).split("\n")
  let hw_pagesize = sysinfo[0].parseUInt
  let mem_total = sysinfo[1].parseUInt div 1024 div 1024
  # let pages_app = sysinfo[2].parseUInt - sysinfo[3].parseUInt

  let vminfo = strip(execProcess("vm_stat"))
  let pages_wired = parseVMStat(vminfo, "Pages wired down").parseUInt
  let pages_compressed = parseVMStat(vminfo, "Pages occupied by compressor").parseUInt
  let pages_active = parseVMStat(vminfo, "Pages active").parseUInt

  let mem_used = (pages_active + pages_wired + pages_compressed) * hw_pagesize div 1024 div 1024
  let mem_label = "MiB"

  result = &"{uint(mem_used)}{mem_label} / {uint(mem_total)}{mem_label}"


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
