# author: Ethosa
#[
### `models.nim` provides working with different color models.
]#
import types


{.push inline.}
func rgb2hsv*(clr: ColorObj): ColorHsv =
  var
    mn = min(min(clr.r, clr.g), clr.b)
    mx = max(max(clr.r, clr.g), clr.b)
    delta = mx - mn

  result.v = mx

  if delta < 0.00001:
      result.s = 0
      result.h = 0
      return result
  if mx > 0f:
      result.s = (delta / mx);
  else:
      result.s = 0f
      result.h = NAN
      return result
  if clr.r >= mx:
      result.h = (clr.g - clr.b) / delta
  elif clr.g >= mx:
      result.h = 2f + (clr.b - clr.r) / delta
  else:
      result.h = 4f + (clr.r - clr.g) / delta

  result.h *= 60f

  if result.h < 0f:
      result.h += 360f


func hsv2rgb*(clr: ColorHsv): ColorObj =
  var
    hh, p, q, t, ff: float
  result.a = 1f

  if clr.s <= 0f:
      result.r = clr.v
      result.g = clr.v
      result.b = clr.v
      return result
  hh = clr.h
  if hh >= 360f:
    hh = 0f
  hh /= 60f

  let i = hh.int()
  ff = hh - i.float()
  p = clr.v * (1f - clr.s)
  q = clr.v * (1f - (clr.s * ff))
  t = clr.v * (1f - (clr.s * (1f - ff)))

  case i:
    of 0:
      result.r = clr.v
      result.g = t
      result.b = p
    of 1:
      result.r = q
      result.g = clr.v
      result.b = p
    of 2:
      result.r = p
      result.g = clr.v
      result.b = t
    of 3:
      result.r = p
      result.g = q
      result.b = clr.v
    of 4:
      result.r = t
      result.g = p
      result.b = clr.v
    else:
      result.r = clr.v
      result.g = p
      result.b = q
  return result

{.pop.}
