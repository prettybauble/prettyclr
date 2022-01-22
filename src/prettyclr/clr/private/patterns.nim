# author: Ethosa
import re


let
  HEX_COLOR_PATTERN* = re(
    "\\A(#|0x)([0-9a-f]{3,6})\\Z",
    {reStudy, reIgnoreCase}
  )
  RGBA_COLOR_PATTERN* = re(
    "\\Argba{0,1}\\s*\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,{0,1}\\s*(\\d*)\\s*\\)\\Z",
    {reStudy, reIgnoreCase}
  )
