import
  prettyclr,
  unittest

suite "Working with colors":
  var
    clr1 = Color(1f, 1f, 0.75)
    clr2 = Color(0.5, 0.5, 0.25)

  test "Create RGBA color":
    var color = Color(255u8, 255, 100, 125)
    echo color

  test "mix two colors":
    var
      color1 = Color(0.5, 1, 0.5, 0)
      color2 = Color(0.75, 0.5, 0.25, 0)
    echo mix(color1, color2, 0.25)

  test "rgba float color to rgba int color":
    echo Color(50, 100, 150, 255).toRgba()

  test "parseColor":
    assert Color(255, 100, 150) == parseColor("rgb(255, 100, 150)")
    assert Color(255, 255, 255) == parseColor("white")
    assert parseColor(0xFFEEFFFF) == parseColor("#fef")
    assert parseColor(0xFFEEFFFF) == parseColor("#feff")

  test "normal blend":
    assert blend(clr1, clr2) == Color(0.75, 0.75, 0.5, 1)

  test "multiply blend":
    assert blend(clr1, clr2, bmMultiply) == Color(0.5, 0.5, 0.1875, 1)

  test "screen blend":
    assert blend(clr1, clr2, bmScreen) == Color(1f, 1f, 0.8125, 1)

  test "hardlight blend":
    assert blend(clr1, clr2, bmHardLight) == Color(0.5, 0.5, 0.15234375, 1)

  test "overlay blend":
    assert blend(clr1, clr2, bmOverlay) == Color(1f, 1f, 0.625, 1f)

  test "softlight blend":
    assert blend(clr1, clr2, bmSoftLight) == Color(0.5, 0.5, 0.75, 0.0)

  test "divide blend":
    assert blend(clr1, clr2, bmDivide) == Color(1f, 1f, 1f, 1f)

  test "subtract blend":
    assert blend(clr1, clr2, bmSubtract) == Color(0.5, 0.5, 0.5, 0.0)

  test "difference blend":
    assert blend(clr1, clr2, bmDifference) == Color(0.5, 0.5, 0.5, 0)

  test "darken only blend":
    assert blend(clr1, clr2, bmDarkenOnly) == Color(0.5, 0.5, 0.5, 1)

  test "lighten only blend":
    assert blend(clr1, clr2, bmLightenOnly) == Color(1f, 1f, 1f, 1f)

  test "rgba to hsv color model":
    var
      rgba_clr = Color(1f, 0.5, 0.25)
      hsv_clr = rgba2hsv(rgba_clr)
    echo hsv_clr
