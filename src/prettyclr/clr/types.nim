# author: Ethosa
## Provides color types
import ../core/enums

type
  ColorObj* = object
    r*, g*, b*, a*: float
  ColorHsl* = object
    kind*: HslMode
    h*: range[0..360]
    s*: float
    l*: float


{.push inline.}
func initColor*: ColorObj =
  ## Creates the white Color object
  ColorObj(r: 1f, g: 1f, b: 1f, a: 1f)

func initColor*(r, g, b: float): ColorObj =
  ## Creates the Color object.
  ColorObj(r: r, g: g, b: b, a: 1f)

func initColor*(r, g, b, a: float): ColorObj =
  ## Creates the Color object.
  ColorObj(r: r, g: g, b: b, a: a)


func clr*: ColorObj =
  ## Creates the new transparent color (0, 0, 0, 0)
  initColor(0, 0, 0, 0)

func clr*(r, g, b: uint8, a: uint8 = 255u8): ColorObj =
  initColor(int(r) / 255, int(g) / 255, int(b) / 255, int(a) / 255)

func clr*(r, g, b: float, a: float = 1f): ColorObj =
  initColor(r, g, b, a)

func hsl*(h: 0..360 = 0, s: 0f32..1f32 = 0, l: 0f32..1f32, kind: HslMode = hmLightness): ColorHsl =
  #[Initializes HSL color model
  See https://en.wikipedia.org/wiki/HSL_and_HSV
  
  `kind` param can be also `hmLarger` (HSV), `hmLuma` (HSY), `hmIntensity` (HSI).
  ]#
  ColorHsl(kind: kind, h: h, s: s, l: l)

{.pop.}
