# author: Ethosa
#[
### `models.nim` provides working with different color models.
]#
import
  ../core/enums,
  types


func rgba2hsl*(clr: ColorObj, kind: HslMode = hmLargest): ColorHsl =
  ## Converts RGBA color model to HSV color model.
  ## https://en.wikipedia.org/wiki/HSV_color_space
  let
    M = max(max(clr.r, clr.b), clr.g)  # maximum color value
    m = min(min(clr.r, clr.b), clr.g)  # minimum color value
    chroma = M - m
    hue =
      if M == clr.r:
        60 * (((clr.g - clr.b)/chroma).int() mod 6)
      elif M == clr.g:
        60 * (((clr.b - clr.r)/chroma).int() + 2)
      elif M == clr.b:
        60 * (((clr.r - clr.g)/chroma).int() + 4)
      else:
        0
    lightness =
      case kind
      of hmIntensity:
        (clr.r + clr.g + clr.b)/3f
      of hmLargest:
        M
      of hmLightness:
        (M + m)/2
      of hmLuma:
        0.2627*clr.r + 0.6780*clr.g + 0.0593*clr.b  # UHDTV/HDR lumination
    saturation =
      case kind
      of hmIntensity:
        if lightness == 0: 0f else: 1f - m/lightness
      of hmLargest:
        if lightness == 0: 0f else: chroma/lightness
      of hmLightness, hmLuma:
        if lightness == 0 or lightness == 1: 0f else: chroma/(1f - abs(2*lightness - 1f))
  ColorHsl(h: hue, s: saturation, l: lightness, kind: kind)

func hslExtractRgb(c, x: float32, hue: int): tuple[r, g, b: float32] =
  if 0 <= hue and hue < 1:
    (c, x, 0f)
  elif 1 <= hue and hue < 2:
    (x, c, 0f)
  elif 2 <= hue and hue < 3:
    (0f, c, x)
  elif 3 <= hue and hue < 4:
    (0f, x, c)
  elif 4 <= hue and hue < 5:
    (x, 0f, c)
  elif 5 <= hue and hue < 6:
    (c, 0f, x)
  else:
    (0f, 0f, 0f)


func hsl2rgba*(clr: ColorHsl): ColorObj =
  ## Converts HSL color model to RGBA.
  case clr.kind
  of hmLightness:
    let
      chroma = clr.s * (1f - abs(2*clr.l - 1f))
      hue = cast[int](clr.h / 60)
      x = chroma * (1f - abs(cast[float](hue mod 2) - 1f))
      (r, g, b) = hslExtractRgb(chroma, x, hue)
      m = clr.l - chroma/2f
    clr(r+m, g+m, b+m)
  of hmLargest:
    let
      chroma = clr.s * clr.l
      hue = cast[int](clr.h / 60)
      x = chroma * (1f - abs(cast[float](hue mod 2) - 1f))
      (r, g, b) = hslExtractRgb(chroma, x, hue)
      m = clr.l - chroma
    clr(r+m, g+m, b+m)
  of hmIntensity:
    let
      hue = cast[int](clr.h / 60)
      z = 1f - abs(cast[float](hue mod 2) - 1f)
      chroma = (3*clr.l*clr.s)/(1+z)
      x = chroma*z
      (r, g, b) = hslExtractRgb(chroma, x, hue)
      m = clr.l*(1f - clr.s)
    clr(r+m, g+m, b+m)
  of hmLuma:
    let
      hue = cast[int](clr.h / 60)
      chroma = clr.s * (1f - abs(2*clr.l - 1f))
      x = chroma * (1f - abs(cast[float](hue mod 2) - 1f))
      (r, g, b) = hslExtractRgb(chroma, x, hue)
      m = (0.2627*r + 0.6780*g + 0.0593*b) - (0.30*r + 0.59*g + 0.11*b)
    clr(r+m, g+m, b+m)
