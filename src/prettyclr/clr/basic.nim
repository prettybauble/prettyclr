# author: Ethosa
import
  ../core/enums,
  strformat,
  types,
  math


{.push inline, discardable.}
func norm(
    v: float,
    mn: float = 0f,
    mx: float = 1f
): float =
  if v > mx:
    mx
  elif v < mn:
    mn
  else:
    v


# ---=== Math ===--- #
func abs*(clr: ColorObj): ColorObj =
  ## Returns positivie color.
  clr(
    abs(clr.r),
    abs(clr.g),
    abs(clr.b),
    abs(clr.a)
  )

func mix*(
    clr1, clr2: ColorObj,
    fraction: float = -1f
): ColorObj =
  ## Mixes two colors
  let f = if fraction == -1f: clr2.a else: fraction
  let
    r = (clr2.r - clr1.r) * f + clr1.r
    g = (clr2.g - clr1.g) * f + clr1.g
    b = (clr2.b - clr1.b) * f + clr1.b
    a = (clr2.a - clr1.a) * f + clr1.a
  clr(r, g, b, a)

func max*(clr1, clr2: ColorObj): ColorObj =
  ## Returns maximum color between `clr1` and `clr2`.
  clr(
    max(clr1.r, clr2.r),
    max(clr1.g, clr2.g),
    max(clr1.g, clr2.g),
    max(clr1.a, clr2.a)
  )

func min*(clr1, clr2: ColorObj): ColorObj =
  ## Returns minimal color between `clr1` and `clr2`.
  clr(
    min(clr1.r, clr2.r),
    min(clr1.g, clr2.g),
    min(clr1.g, clr2.g),
    min(clr1.a, clr2.a)
  )

func normalize*(clr: ColorObj): ColorObj =
  ## Normalizes Color object.
  result = clr
  result.r = norm(result.r)
  result.g = norm(result.g)
  result.b = norm(result.b)
  result.a = norm(result.a)

func round*(clr: ColorObj, place: int): ColorObj =
  ## Rounds the color object.
  clr(
    round(clr.r, place),
    round(clr.g, place),
    round(clr.b, place),
    round(clr.a, place)
  )

func pow*(clr: ColorObj, power: float): ColorObj =
  ## Returns positivie color.
  clr(
    pow(clr.r, power),
    pow(clr.g, power),
    pow(clr.b, power),
    pow(clr.a, power)
  )

func sqrt*(clr: ColorObj): ColorObj =
  ## Returns positivie color.
  clr(
    sqrt(clr.r),
    sqrt(clr.g),
    sqrt(clr.b),
    sqrt(clr.a)
  )


# ---=== Color functions ===--- #
func bright*(
    clr: ColorObj,
    include_alpha: bool = false
): float =
  ## Returns color bright
  if include_alpha:
    (clr.r + clr.g + clr.b)/3
  else:
    (clr.r + clr.g + clr.b + clr.a)/4

func grayscale*(clr: ColorObj): ColorObj =
  ## Returns color divided by 3
  let bright = (clr.r + clr.g + clr.b)/3
  clr(bright, bright, bright)

func invert*(clr: ColorObj): ColorObj =
  ## Returns inverted color
  clr(
    abs(1f - clr.r),
    abs(1f - clr.g),
    abs(1f - clr.b),
    abs(1f - clr.a)
  )

func mono*(clr: ColorObj): ColorObj =
  ## Returns color divided by 3
  let bright = round((clr.r + clr.g + clr.b)/3)
  clr(bright, bright, bright)


# ---=== HSV === --- #
func rotate*(clr: ColorHsv, value: float): ColorHsv =
  ## Rotates hue color
  var hue = clr.h + value
  while hue > 360f or hue < 0f:
    hue = abs(360f - abs(hue))
  hsv(hue, clr.s, clr.v)

func complementary*(clr: ColorHsv): ColorHsv =
  ## Returns complementary color
  clr.rotate(180)

func triad*(clr: ColorHsv): array[2, ColorHsv] =
  ## Returns triad colors
  [clr.rotate(120), clr.rotate(-120)]

func analogous*(clr: ColorHsv): array[2, ColorHsv] =
  ## Returns analogous colors
  [clr.rotate(-30), clr.rotate(30)]

func tetradic*(clr: ColorHsv): array[3, ColorHsv] =
  ## Returns tetradic colors
  [clr.rotate(90), clr.rotate(180), clr.rotate(240)]

func square*(clr: ColorHsv): array[3, ColorHsv] =
  ## Returns square colors
  [clr.rotate(90), clr.rotate(180), clr.rotate(270)]


# ---=== Operators === --- #
func `==`*(clr1, clr2: ColorObj): bool =
  clr1.r == clr2.r and clr1.g == clr2.g and
    clr1.b == clr2.b and clr1.a == clr2.a

func `+`*(clr1, clr2: ColorObj): ColorObj =
  clr(
    clr1.r + clr2.r,
    clr1.g + clr2.g,
    clr1.b + clr2.b,
    clr1.a + clr2.a
  )

func `-`*(clr1, clr2: ColorObj): ColorObj =
  clr(
    clr1.r - clr2.r,
    clr1.g - clr2.g,
    clr1.b - clr2.b,
    clr1.a - clr2.a
  )

func `/`*(clr1, clr2: ColorObj): ColorObj =
  clr(
    clr1.r / clr2.r,
    clr1.g / clr2.g,
    clr1.b / clr2.b,
    clr1.a / clr2.a
  )

func `*`*(clr1, clr2: ColorObj): ColorObj =
  clr(
    clr1.r * clr2.r,
    clr1.g * clr2.g,
    clr1.b * clr2.b,
    clr1.a * clr2.a
  )


func `+`*(clr: ColorObj, v: float): ColorObj =
  initColor(clr.r + v, clr.g + v, clr.b + v, clr.a + v)

func `-`*(clr: ColorObj, v: float): ColorObj =
  initColor(clr.r - v, clr.g - v, clr.b - v, clr.a - v)

func `/`*(clr: ColorObj, v: float): ColorObj =
  initColor(clr.r / v, clr.g / v, clr.b / v, clr.a / v)

func `*`*(clr: ColorObj, v: float): ColorObj =
  initColor(clr.r * v, clr.g * v, clr.b * v, clr.a * v)

func `+`*(v: float, clr: ColorObj): ColorObj =
  initColor(v + clr.r, v + clr.g, v + clr.b, v + clr.a)

func `-`*(v: float, clr: ColorObj): ColorObj =
  initColor(v - clr.r, v - clr.g, v - clr.b, v - clr.a)

func `/`*(v: float, clr: ColorObj): ColorObj =
  initColor(v / clr.r, v / clr.g, v / clr.b, v / clr.a)

func `*`*(v: float, clr: ColorObj): ColorObj =
  initColor(v * clr.r, v * clr.g, v * clr.b, v * clr.a)


func `+=`*(clr: var ColorObj, v: float | ColorObj) =
  clr = clr + v

func `-=`*(clr: var ColorObj, v: float | ColorObj) =
  clr = clr - v

func `/=`*(clr: var ColorObj, v: float | ColorObj) =
  clr = clr / v

func `*=`*(clr: var ColorObj, v: float | ColorObj) =
  clr = clr * v

func `$`*(clr: ColorObj): string =
  fmt"Color<{clr.r}, {clr.g}, {clr.b}, {clr.a}>"

func `$`*(clr: ColorHsv): string =
  fmt"HSV Color<[{clr.h}, {clr.s}, {clr.v}]>"


func blend*(
    clr1, clr2: ColorObj,
    mode: BlendMode = bmNormal
): ColorObj =
  #[ Blends two colors.
     `clr1` and `clr2` is color objects.
     `mode` blend mode]#
  case mode
  of bmNormal:
    mix(clr1, clr2)
  of bmMultiply:
    normalize(clr1*clr2)
  of bmAddition:
    normalize(clr1+clr2)
  of bmSubtract:
    normalize(clr1-clr2)
  of bmDivide:
    normalize(clr1/clr2)
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


iterator walk*(
    clr1, clr2: ColorObj,
    step_count: int = 100
): ColorObj {.used.} =
  ## Goes from one color to another
  let step = (clr2 - clr1) / step_count.float()
  for i in 1..step_count:
    yield clr1 + step*i.float()
