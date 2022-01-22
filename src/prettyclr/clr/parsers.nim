# author: Ethosa
import
  ../core/exceptions,
  private/patterns,
  private/colors,
  strutils,
  basic,
  tables,
  types,
  re


{.push inline.}

func parseclr*(src: SomeSignedInt): ColorObj =
  #[Parses HEX integer to ColorObj.
  
  # Example
  ```nim
  assert parseclr(0xFF00FF00) == initColor(1f, 0f, 1f, 0f)
  ```
  ]#
  ColorObj(
    r: float(((uint32(src) shr 24) and 255)) / 255,
    g: float(((uint32(src) shr 16) and 255)) / 255,
    b: float(((uint32(src) shr 8) and 255)) / 255,
    a: float((uint32(src) and 255)) / 255
  )


proc parseclr*(src: string): ColorObj =
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
    return parseclr(parseHexInt('#' & clr))

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

{.pop.}
