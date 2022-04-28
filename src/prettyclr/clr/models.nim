# author: Ethosa
#[
### `models.nim` provides working with different color models.
]#
import
  ../core/enums,
  basic,
  types,
  math


func rgba2hsl*(clr: ColorObj, kind: HslMode = hmLargest): ColorHsl =
  ## Converts RGBA color model to HSV color model.
  ## https://en.wikipedia.org/wiki/HSV_color_space
  let
    M = max(max(clr.r, clr.b), clr.g)  # maximum color value
    m = min(min(clr.r, clr.b), clr.g)  # minimum color value
    chroma = M - m
    hue =
      if M == clr.r:
        (clr.g - clr.b)/chroma
      elif M == clr.g:
        (clr.g - clr.b)/chroma + 2f
      elif M == clr.b:
        (clr.g - clr.b)/chroma + 4f
      else:
        0f
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
        if lightness == 0:
          0f
        else:
          1f - m/lightness
      of hmLargest:
        if lightness == 0:
          0f
        else:
          chroma/lightness
      of hmLightness, hmLuma:
        if lightness == 0 or lightness == 1:
          0f
        else:
          chroma/(1f - abs(2*lightness - 1f))
  ColorHsl(h: hue, s: saturation, l: lightness, kind: kind)

func hue2rgb(p, q: float, t: var float): float =
  if t < 0:
    t += 1f
  elif t > 1:
    t -= 1f
  elif t < 1/6:
    return p + (q - p) * 6 * t
  elif t < 1/2:
    return q
  elif t < 2/3:
    return p + (q - p) * (2/3 - t) * 6
  p


func hsl2rgba*(clr: ColorHsl): ColorObj =
  ## Converts HSL color model to RGBA.
  var
    q =
      if clr.l < 0.5:
        clr.l * (1 + clr.s)
      else:
        clr.l + clr.s - clr.l * clr.s
    p = 2 * clr.l - q
    tr = clr.h + 1/3
    tg = clr.h
    tb = clr.h - 1/3
  let
    (r, g, b) = (hue2rgb(p, q, tr), hue2rgb(p, q, tg), hue2rgb(p, q, tb))
  case clr.kind
  of hmLightness:
    clr(r, g, b)
  of hmLargest:
    let
      chroma = clr.l*clr.s
      m = clr.l - chroma
    clr(r+m, g+m, b+m)
  of hmIntensity:
    let
      hue = cast[int](clr.h / 60)
      z = 1f - abs(cast[float](hue mod 2) - 1f)
      chroma = (3*clr.l*clr.s)/(1+z)
      m = clr.l*(1f - clr.s)
    normalize(abs(clr(r+m, g+m, b+m)))
  of hmLuma:
    let
      hue = cast[int](clr.h / 60)
      chroma = clr.s * (1f - abs(2*clr.l - 1f))
      m = (0.2627*r + 0.6780*g + 0.0593*b) - (0.30*r + 0.59*g + 0.11*b)
    normalize(abs(clr(r+m, g+m, b+m)))
