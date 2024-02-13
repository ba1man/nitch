import std/osproc
import std/strutils

proc getUptime*(): string =
  let res = execProcess("sysctl -n kern.boottime")
  let uptimeUint = res.split("usec = ")[1].split(" }")[0].parseUInt
  let uptimeHours = uptimeUint div 3600 mod 24
  let uptimeMinutes = uptimeUint mod 3600 div 60
  let uptimeDays = uptimeUint div 3600 div 24 

  if uptimeDays == 0:
    result = $(uptimeHours) & "h " & $(uptimeMinutes) & "m"

  elif uptimeHours == 0 and uptimeDays == 0:
    result = $(uptimeMinutes) & "m"

  else:
    result = $(uptimeDays) & "d " & $(uptimeHours) & "h " & $(uptimeMinutes) & "m"