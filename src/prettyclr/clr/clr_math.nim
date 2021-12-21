# author: Ethosa
import
  types,
  math


func normalize*(clr: ColorAny): ColorObj =
  ## Normalizes Color object.
  result = clr
  result.r = if result.r > 1f: 1f elif result.r < 0f: 0f else: result.r
  result.g = if result.g > 1f: 1f elif result.g < 0f: 0f else: result.g
  result.b = if result.b > 1f: 1f elif result.b < 0f: 0f else: result.b
  result.a = if result.a > 1f: 1f elif result.a < 0f: 0f else: result.a

func mix*(clr1, clr2: ColorAny): ColorObj =
  ## Mixes two colors
  let
    r = (clr2.r - clr1.r) * clr.a + clr1.r
    g = (clr2.g - clr1.g) * clr.a + clr1.g
    b = (clr2.b - clr1.b) * clr.a + clr1.b
    a = (clr2.a - clr1.a) * clr.a + clr1.a
  Color(r, g, b, a)

func mix*(clr1, clr2: ColorAny, fraction: float): ColorObj =
  ## Mixes two colors
  let
    r = (clr2.r - clr1.r) * fraction + clr1.r
    g = (clr2.g - clr1.g) * fraction + clr1.g
    b = (clr2.b - clr1.b) * fraction + clr1.b
    a = (clr2.a - clr1.a) * fraction + clr1.a
  Color(r, g, b, a)

func max*(clr1, clr2: ColorAny): ColorObj =
  ## Returns minimal color.
  Color(max(clr1.r, clr2.r), max(clr1.g, clr2.g), max(clr1.g, clr2.g), max(clr1.a, clr2.a))

func min*(clr1, clr2: ColorAny): ColorObj =
  ## Returns minimal color.
  Color(min(clr1.r, clr2.r), min(clr1.g, clr2.g), min(clr1.g, clr2.g), min(clr1.a, clr2.a))

func abs*(clr: ColorAny): ColorObj =
  ## Returns positivie color.
  Color(abs(clr.r), abs(clr.g), abs(clr.b), abs(clr.a))

func sqrt*(clr: ColorAny): ColorObj =
  ## Returns positivie color.
  Color(sqrt(clr.r), sqrt(clr.g), sqrt(clr.b), sqrt(clr.a))

func pow*(clr: ColorAny, power: float): ColorObj =
  ## Returns positivie color.
  Color(pow(clr.r, power), pow(clr.g, power), pow(clr.b, power), pow(clr.a, power))

func bright*(clr: ColorAny): float =
  ## Returns color bright
  (clr.r + clr.g + clr.b + clr.a)/4


# ---- Operators ---- #
func `==`*(clr1, clr2: ColorAny): bool =
  clr1.r == clr2.r and clr1.g == clr2.g and clr1.b == clr2.b and clr1.a == clr2.a

func `+`*(clr1, clr2: ColorAny): ColorObj =
  normalize(Color(
    clr1.r + clr2.r, clr1.g + clr2.g,
    clr1.b + clr2.b, clr1.a + clr2.a))

func `-`*(clr1, clr2: ColorAny): ColorObj =
  normalize(Color(
    clr1.r - clr2.r, clr1.g - clr2.g,
    clr1.b - clr2.b, clr1.a - clr2.a))

func `/`*(clr1, clr2: ColorAny): ColorObj =
  normalize(Color(
    clr1.r / clr2.r, clr1.g / clr2.g,
    clr1.b / clr2.b, clr1.a / clr2.a))

func `*`*(clr1, clr2: ColorAny): ColorObj =
  normalize(Color(
    clr1.r * clr2.r, clr1.g * clr2.g,
    clr1.b * clr2.b, clr1.a * clr2.a))


func `+`*(clr: ColorAny, v: float): ColorObj =
  normalize(Color(clr.r + v, clr.g + v, clr.b + v, clr.a + v))

func `-`*(clr: ColorAny, v: float): ColorObj =
  normalize(Color(clr.r - v, clr.g - v, clr.b - v, clr.a - v))

func `/`*(clr: ColorAny, v: float): ColorObj =
  normalize(Color(clr.r / v, clr.g / v, clr.b / v, clr.a / v))

func `*`*(clr: ColorAny, v: float): ColorObj =
  normalize(Color(clr.r * v, clr.g * v, clr.b * v, clr.a * v))

func `+`*(v: float, clr: ColorAny): ColorObj =
  normalize(Color(v + clr.r, v + clr.g, v + clr.b, v + clr.a))

func `-`*(v: float, clr: ColorAny): ColorObj =
  normalize(Color(v - clr.r, v - clr.g, v - clr.b, v - clr.a))

func `/`*(v: float, clr: ColorAny): ColorObj =
  normalize(Color(v / clr.r, v / clr.g, v / clr.b, v / clr.a))

func `*`*(v: float, clr: ColorAny): ColorObj =
  normalize(Color(v * clr.r, v * clr.g, v * clr.b, v * clr.a))