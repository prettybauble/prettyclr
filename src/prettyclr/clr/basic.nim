# author: Ethosa
import
  ../core/enums,
  strformat,
  types,
  math


{.push inline.}
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

func normalize*(clr: ColorObj): ColorObj =
  ## Normalizes Color object.
  result = clr
  result.r = norm(result.r)
  result.g = norm(result.g)
  result.b = norm(result.b)
  result.a = norm(result.a)

func mix*(clr1, clr2: ColorObj): ColorObj =
  ## Mixes two colors
  let
    r = (clr2.r - clr1.r) * clr2.a + clr1.r
    g = (clr2.g - clr1.g) * clr2.a + clr1.g
    b = (clr2.b - clr1.b) * clr2.a + clr1.b
    a = (clr2.a - clr1.a) * clr2.a + clr1.a
  clr(r, g, b, a)

func mix*(clr1, clr2: ColorObj, fraction: 0f..1f): ColorObj =
  ## Mixes two colors
  let
    r = (clr2.r - clr1.r) * fraction + clr1.r
    g = (clr2.g - clr1.g) * fraction + clr1.g
    b = (clr2.b - clr1.b) * fraction + clr1.b
    a = (clr2.a - clr1.a) * fraction + clr1.a
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

func abs*(clr: ColorObj): ColorObj =
  ## Returns positivie color.
  clr(abs(clr.r), abs(clr.g), abs(clr.b), abs(clr.a))

func sqrt*(clr: ColorObj): ColorObj =
  ## Returns positivie color.
  clr(sqrt(clr.r), sqrt(clr.g), sqrt(clr.b), sqrt(clr.a))

func pow*(clr: ColorObj, power: float): ColorObj =
  ## Returns positivie color.
  clr(
    pow(clr.r, power),
    pow(clr.g, power),
    pow(clr.b, power),
    pow(clr.a, power)
  )

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

func mono*(clr: ColorObj): ColorObj =
  ## Returns color divided by 3
  let bright = (clr.r + clr.g + clr.b)/3
  clr()


# ---- Operators ---- #
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

func `$`*(clr: ColorHsl): string =
  fmt"Color<[{clr.h}, {clr.s}, {clr.l}] with {clr.kind}>"


func blend*(
    clr1, clr2: ColorObj,
    mode: BlendMode = bmNormal
): ColorObj =
  ## Blends two colors.
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


iterator walk(
    clr1, clr2: ColorObj,
    step_count: int = 100
): ColorObj {.used.} =
  ## Goes from one color to another
  var color = clr1
  let step = (clr2 - clr1) / cast[float](step_count)
  for i in 0..step_count:
    color = color + step
    yield color
