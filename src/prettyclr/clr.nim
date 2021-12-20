# author: Ethosa
import
  exceptions,
  clr_list,
  strutils,
  clr_math,
  tables,
  types,
  enums,
  re


let
  HEX_COLOR_PATTERN = re(
    "\\A(#|0x)([0-9a-f]{3,6})\\Z",
    {reStudy, reIgnoreCase}
  )
  RGBA_COLOR_PATTERN = re(
    "\\Argba{0,1}\\s*\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,{0,1}\\s*(\\d*)\\s*\\)\\Z",
    {reStudy, reIgnoreCase}
  )


{.push inline.}

func parseColor*(src: SomeSignedInt): ColorObj =
  ## Parses HEX integer to ColorObj.
  ColorObj(
    r: float(((uint32(src) shr 24) and 255)) / 255,
    g: float(((uint32(src) shr 16) and 255)) / 255,
    b: float(((uint32(src) shr 8) and 255)) / 255,
    a: float((uint32(src) and 255)) / 255
  )


proc parseColor*(src: string): ColorObj =
  ## Parses color if available.
  ##
  ## `clr` can be HEX string (0xfffe, 0xfefefe, 0xfff, #fff, etc.)
  ## also `clr` can be rgb(255, 100, 100) or rgba(100, 100, 100, 100)
  var matched: array[20, string]

  if match(src, HEX_COLOR_PATTERN, matched):
    var clr = matched[1]
    case clr.len()
    of 3:
      clr = clr[0] & clr[0] & clr[1] & clr[1] & clr[2] & clr[2] & "ff"
    of 4:
      clr = clr[0] & clr[0] & clr[1] & clr[1] & clr[2] & clr[2] & clr[3] & clr[3]
    of 6, 8:
      discard
    else:
      raise newException(ColorStringParseError, src & " isn't color!")
    return parseColor(parseHexInt('#' & clr))

  if match(src, RGBA_COLOR_PATTERN, matched):
    return initColor(
      parseInt(matched[0]) / 255,
      parseInt(matched[1]) / 255,
      parseInt(matched[2]) / 255,
      if matched[3] != "": parseInt(matched[3]) / 255 else: 1f,
    )

  if src in color_list:
    let clr = color_list[src]
    return initColor(clr[0] / 255, clr[1] / 255, clr[2] / 255, 1f)

  raise newException(ColorStringParseError, src & " isn't color!")

func toFloat*(color: ColorRgba): ColorObj =
  ## Converts color object to float color object.
  initColor(
    float(color.r) / 255, float(color.g) / 255,
    float(color.b) / 255, float(color.a) / 255)

func toInt*(color: ColorAny): ColorRgba =
  ## Converts color object to float color object.
  ColorRgba(
    r: uint8(color.r * 255), g: uint8(color.g * 255),
    b: uint8(color.b * 255), a: uint8(color.a * 255))


func blend*(clr1, clr2: ColorAny, mode: BlendMode = bmNormal): ColorObj =
  ## Blends two colors.
  case mode
  of bmNormal:
    mix(clr1, clr2)
  of bmMultiply:
    clr1*clr2
  of bmAddition:
    clr1+clr2
  of bmSubtract:
    clr1-clr2
  of bmDivide:
    clr1/clr2
  of bmDifference:
    abs(clr1-clr2)
  of bmDarkenOnly:
    min(clr1,clr2)
  of bmLightenOnly:
    max(clr1,clr2)
  of bmScreen:
    1f - (1f - clr1)*(1f - clr2)
  of bmHardLight:
    (clr1*clr2) * (1f - (1f - clr1)*(1f - clr2))
  of bmOverlay:
    if bright(clr1) < 0.5:
      2f*clr1*clr2
    else:
      1f - 2f*(1f - clr1)*(1f - clr2)
  of bmSoftLight:
    if bright(clr1) < 0.5:
      normalize(2f*clr1*clr2 + pow(clr1, 2f)*(1f - 2f*clr2))
    else:
      normalize(2f*clr1*(1f - clr2) + sqrt(clr1)*(2f*clr2 - 1f))

{.pop.}
