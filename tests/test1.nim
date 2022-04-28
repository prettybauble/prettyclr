import
  prettyclr,
  unittest

suite "Working with colors":
  var
    clr1 = clr(1f, 1f, 0.75)
    clr2 = clr(0.5, 0.5, 0.25)

  test "Create RGBA color":
    var color = clr(255u8, 255, 100, 125)
    echo color

  test "mix two colors":
    var
      color1 = clr(0.5, 1, 0.5)
      color2 = clr(0.75, 0.5, 0.25)
    echo mix(color1, color2, 0.25)

  test "rgba float color to rgba int color":
    echo clr(50, 100, 150, 255)

  test "parseclr":
    assert clr(255, 100, 150) == parseclr("rgb(255, 100, 150)")
    assert clr(255, 255, 255) == parseclr("white")
    assert parseclr(0xFFEEFFFF) == parseclr("#fef")
    assert parseclr(0xFFEEFFFF) == parseclr("#feff")

  test "normal blend":
    assert blend(clr1, clr2) == clr2

  test "multiply blend":
    assert blend(clr1, clr2, bmMultiply) == clr(0.5, 0.5, 0.1875, 1)

  test "screen blend":
    assert blend(clr1, clr2, bmScreen) == clr(1f, 1f, 0.8125, 1)

  test "hardlight blend":
    assert blend(clr1, clr2, bmHardLight) == clr(0.5, 0.5, 0.15234375, 1)

  test "overlay blend":
    assert blend(clr1, clr2, bmOverlay) == clr(1f, 1f, 0.625, 1f)

  test "softlight blend":
    echo blend(clr1, clr2, bmSoftLight)

  test "divide blend":
    assert blend(clr1, clr2, bmDivide) == clr(1f, 1f, 1f)

  test "subtract blend":
    assert blend(clr1, clr2, bmSubtract) == clr(0.5, 0.5, 0.5, 0.0)

  test "difference blend":
    assert blend(clr1, clr2, bmDifference) == clr(0.5, 0.5, 0.5, 0)

  test "darken only blend":
    assert blend(clr1, clr2, bmDarkenOnly) == clr(0.5, 0.5, 0.5, 1)

  test "lighten only blend":
    assert blend(clr1, clr2, bmLightenOnly) == clr(1f, 1f, 1f, 1f)

  test "HSL color model":
    var
      rgba_clr = clr(1f, 0.5, 0.25)
    echo rgba2hsl(rgba_clr, hmLargest)
    echo rgba2hsl(rgba_clr, hmLightness)
    echo rgba2hsl(rgba_clr, hmIntensity)
    echo rgba2hsl(rgba_clr, hmLuma)
    echo hsl2rgba(rgba2hsl(rgba_clr, hmLargest))
    echo hsl2rgba(rgba2hsl(rgba_clr, hmLightness))
    echo hsl2rgba(rgba2hsl(rgba_clr, hmIntensity))
    echo hsl2rgba(rgba2hsl(rgba_clr, hmLuma))
