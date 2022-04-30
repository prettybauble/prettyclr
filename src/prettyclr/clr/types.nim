# author: Ethosa
## Provides color types

type
  ColorObj* = object
    r*, g*, b*, a*: float
  ColorHsv* = object
    h*, s*, v*, a*: float
  Color255* = object
    r*, g*, b*, a*: uint8


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
  ## Creates transparent color (0, 0, 0, 0)
  initColor(0, 0, 0, 0)

func clr*(v: float, a: float = 1f): ColorObj =
  ## Creates grayscale color
  initColor(v, v, v, a)

func clr*(r, g, b: uint8, a: uint8 = 255u8): ColorObj =
  #[ Initializes the color object
     with RGBA values in 0..255 range ]#
  initColor(
    int(r) / 255,
    int(g) / 255,
    int(b) / 255,
    int(a) / 255
  )

func rgb*(rgba: Color255): ColorObj =
  clr(rgba.r, rgba.g, rgba.b, rgba.a)

func clr*(r, g, b: float, a: float = 1f): ColorObj =
  #[ Initializes the color object
     with RGBA values in 0..1 range ]#
  initColor(r, g, b, a)

func hsv*(
    h, s, v, a: float = 0
): ColorHsv =
  #[Initializes HSL color model
  See https://en.wikipedia.org/wiki/HSL_and_HSV
  
  `kind` param can be also `hmLarger` (HSV), `hmLuma` (HSY), `hmIntensity` (HSI).
  ]#
  ColorHsv(h: h, s: s, v: v, a: a)

func rgb*(
  r, g, b, a: uint8 = 255u8
): Color255 =
  Color255(r: r, g: g, b: b, a: a)

{.pop.}
