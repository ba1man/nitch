import std/[
  times,
  strutils,
  osproc
]

proc getUptime*(): string =
  let info= strip(execProcess("sysctl -n kern.boottime"))
  let now = int(toUnix(now().toTime))
  let uptimeUint = now - info.substr(find(info, "sec = ") + 6, find(info, ", ") - 1).parseInt
  let uptimeHours = uptimeUint div 3600 mod 24
  let uptimeMinutes = uptimeUint mod 3600 div 60
  let uptimeDays = uptimeUint div 3600 div 24

  if uptimeDays == 0:
    result = $(uptimeHours) & "h " & $(uptimeMinutes) & "m"

  elif uptimeHours == 0 and uptimeDays == 0:
    result = $(uptimeMinutes) & "m"

  else:
    result = $(uptimeDays) & "d " & $(uptimeHours) & "h " & $(uptimeMinutes) & "m"