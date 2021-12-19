# author: Ethosa

type
  BlendMode* {.pure, size: sizeof(int8).} = enum
    bmNormal,  # f(a,b) = alpha(a,b)
    bmMultiply,  # f(a,b) = ab
    bmScreen,  # f(a,b) = 1 - (1 - a)(1 - b)
    bmHardLight,  # f(a,b) = multiply(a,b)screen(a,b)
    bmOverlay,  # f(a,b) = a < 0.5 ? 2ab : 1 - 2(1 - a)(1 - b)
    bmSoftLight,  # f(a,b) = b < 0.5 ? 2ab + a^2(1 - 2b) : 2a(1 - b) + sqrt(a)(2b - 1)
    bmDivide,  # f(a,b) = a / b
    bmAddition,  # f(a,b) = a + b
    bmSubtract,  # f(a,b) = a - b
    bmDifference,  # f(a,b) = abs(a - b)
    bmDarkenOnly,  # f(a,b) = min(a.r,b.r),min(a.g,b.g),..
    bmLightenOnly  # f(a,b) = max(a.r,b.r),max(a.g,b.g),..
