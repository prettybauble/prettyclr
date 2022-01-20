# author: Ethosa

type
  ColorRef* = ref ColorObj
  ColorAny* = ColorObj | ColorRef
  ColorObj* = object
    r*, g*, b*, a*: float
  ColorRgba* = object
    r*, g*, b*, a*: uint8
  ColorHsv* = object
    h*: 0..360
    s*, v*: float


{.push inline.}
func initColor*: ColorObj =
  ## Creates the white Color object
  ColorObj(r: 1f, g: 1f, b: 1f, a: 1f)

func newColor*: ColorRef =
  ## Creates the new white Color object.
  ColorRef(r: 1f, g: 1f, b: 1f, a: 1f)


func initColor*(r, g, b: float): ColorObj =
  ## Creates the Color object.
  ColorObj(r: r, g: g, b: b, a: 1f)

func newColor*(r, g, b: float): ColorRef =
  ## Creates the new Color object.
  ColorRef(r: r, g: g, b: b, a: 1f)


func initColor*(r, g, b, a: float): ColorObj =
  ## Creates the Color object.
  ColorObj(r: r, g: g, b: b, a: a)

func newColor*(r, g, b, a: float): ColorRef =
  ## Creates the new Color object.
  ColorRef(r: r, g: g, b: b, a: a)


func Color*: ColorObj =
  ## Creates the new transparent color (0, 0, 0, 0)
  initColor(0, 0, 0, 0)

func Color*(r, g, b: uint8, a: uint8 = 255u8): ColorObj =
  initColor(int(r) / 255, int(g) / 255, int(b) / 255, int(a) / 255)

func Color*(r, g, b: float, a: float = 1f): ColorObj =
  initColor(r, g, b, a)

func hsv*(h: 0..360, s: 0f..1f = 1f, v: 0f..1f = 1f): ColorHsv =
  ## Creates a new color in HSV color model.
  ColorHsv(h: h, s: s, v: v)

{.pop.}
