import 'dart:math' as math;

import 'package:material_color_utilities/src/utils/color_utils.dart';

import '../utils/math_utils.dart';

final class ViewingConditions {
  static final ViewingConditions standard = sRgb;
  static final ViewingConditions sRgb =
      ViewingConditions.defaultWithBackgroundLstar(50.0);

  static const List<List<double>> _xyzToCam16rgb = [
    [0.401288, 0.650173, -0.051461],
    [-0.250268, 1.204414, 0.045854],
    [-0.002079, 0.048952, 0.953127],
  ];

  final double aw;
  final double nbb;
  final double ncb;
  final double c;
  final double nc;
  final double n;
  final List<double> rgbD;
  final double fl;
  final double flRoot;
  final double z;

  const ViewingConditions._(
    this.n,
    this.aw,
    this.nbb,
    this.ncb,
    this.c,
    this.nc,
    this.rgbD,
    this.fl,
    this.flRoot,
    this.z,
  );

  factory ViewingConditions.make(
    List<double> whitePoint,
    double adaptingLuminance,
    double backgroundLstar,
    double surround,
    bool discountingIlluminant,
  ) {
    // A background of pure black is non-physical and leads to infinities that represent the idea
    // that any color viewed in pure black can't be seen.
    backgroundLstar = math.max(0.1, backgroundLstar);
    // Transform white point XYZ to 'cone'/'rgb' responses
    const matrix = _xyzToCam16rgb;
    final xyz = whitePoint;
    final rW =
        (xyz[0] * matrix[0][0]) +
        (xyz[1] * matrix[0][1]) +
        (xyz[2] * matrix[0][2]);
    final gW =
        (xyz[0] * matrix[1][0]) +
        (xyz[1] * matrix[1][1]) +
        (xyz[2] * matrix[1][2]);
    final bW =
        (xyz[0] * matrix[2][0]) +
        (xyz[1] * matrix[2][1]) +
        (xyz[2] * matrix[2][2]);
    final f = 0.8 + (surround / 10.0);
    final c = (f >= 0.9)
        ? MathUtils.lerp(0.59, 0.69, ((f - 0.9) * 10.0))
        : MathUtils.lerp(0.525, 0.59, ((f - 0.8) * 10.0));
    double d = discountingIlluminant
        ? 1.0
        : f *
              (1.0 -
                  ((1.0 / 3.6) * math.exp((-adaptingLuminance - 42.0) / 92.0)));
    d = MathUtils.clampDouble(0.0, 1.0, d);
    final nc = f;
    final rgbD = [
      d * (100.0 / rW) + 1.0 - d,
      d * (100.0 / gW) + 1.0 - d,
      d * (100.0 / bW) + 1.0 - d,
    ];
    final k = 1.0 / (5.0 * adaptingLuminance + 1.0);
    final k4 = k * k * k * k;
    final k4F = 1.0 - k4;
    final fl =
        (k4 * adaptingLuminance) +
        (0.1 *
            k4F *
            k4F *
            math.pow(5.0 * adaptingLuminance, 1.0 / 3.0).toDouble());
    final n = (ColorUtils.yFromLstar(backgroundLstar) / whitePoint[1]);
    final z = 1.48 + math.sqrt(n);
    final nbb = 0.725 / math.pow(n, 0.2);
    final ncb = nbb;
    final rgbAFactors = [
      math.pow(fl * rgbD[0] * rW / 100.0, 0.42),
      math.pow(fl * rgbD[1] * gW / 100.0, 0.42),
      math.pow(fl * rgbD[2] * bW / 100.0, 0.42),
    ];

    final rgbA = [
      (400.0 * rgbAFactors[0]) / (rgbAFactors[0] + 27.13),
      (400.0 * rgbAFactors[1]) / (rgbAFactors[1] + 27.13),
      (400.0 * rgbAFactors[2]) / (rgbAFactors[2] + 27.13),
    ];

    double aw = ((2.0 * rgbA[0]) + rgbA[1] + (0.05 * rgbA[2])) * nbb;
    return ViewingConditions._(
      n,
      aw,
      nbb,
      ncb,
      c,
      nc,
      rgbD,
      fl,
      math.pow(fl, 0.25).toDouble(),
      z,
    );
  }

  factory ViewingConditions.defaultWithBackgroundLstar(double lstar) =>
      ViewingConditions.make(
        ColorUtils.whitePointD65(),
        (200.0 / math.pi * ColorUtils.yFromLstar(50.0) / 100.0),
        lstar,
        2.0,
        false,
      );
}
