# author: Ethosa
import
  ../core/exceptions,
  patterns,
  clr_list,
  strutils,
  clr_math,
  tables,
  types,
  re



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

func toRgba*(color: ColorAny): ColorRgba =
  ## Converts color object to float color object.
  ColorRgba(
    r: uint8(color.r * 255), g: uint8(color.g * 255),
    b: uint8(color.b * 255), a: uint8(color.a * 255))

func rgba2hsv*(clr: ColorAny): ColorHsv =
  ## Converts RGBA color model to HSV color model.
  ## https://en.wikipedia.org/wiki/HSV_color_space
  let
    max_rgba = max(max(clr.r, clr.b), clr.g)
    min_rgba = min(min(clr.r, clr.b), clr.g)
    h: 0..360 =
      if max_rgba == min_rgba:
        0
      elif max_rgba == clr.r and clr.g >= clr.b:
        int(60 * ((clr.g - clr.b) / (max_rgba - min_rgba)))
      elif max_rgba == clr.r and clr.g < clr.b:
        int(60 * ((clr.g - clr.b) / (max_rgba - min_rgba)) + 360)
      elif max_rgba == clr.g:
        int(60 * ((clr.b - clr.r) / (max_rgba - min_rgba)) + 120)
      elif max_rgba == clr.b:
        int(60 * ((clr.r - clr.g) / (max_rgba - min_rgba)) + 240)
      else:
        0
    s =
      if max_rgba == 0:
        0f
      else:
        1f - min_rgba/max_rgba
    v = max_rgba
  ColorHsv(h: h, s: s, v: v)

{.pop.}
