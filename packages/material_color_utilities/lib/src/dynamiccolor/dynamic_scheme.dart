import 'dart:math' as math;

import '../hct/hct.dart';
import '../palettes/tonal_palette.dart';
import '../utils/math_utils.dart';
import 'color_spec.dart';
import 'color_specs.dart';
import 'dynamic_color.dart';
import 'variant.dart';

enum Platform { phone, watch }

class DynamicScheme {
  static const SpecVersion defaultSpecVersion = SpecVersion.spec2021;
  static const Platform defaultPlatform = Platform.phone;

  DynamicScheme({
    required this.sourceColorHct,
    required this.variant,
    required this.isDark,
    required this.contrastLevel,
    this.platform = defaultPlatform,
    this.specVersion = defaultSpecVersion,
    required this.primaryPalette,
    required this.secondaryPalette,
    required this.tertiaryPalette,
    required this.neutralPalette,
    required this.neutralVariantPalette,
    TonalPalette? errorPalette,
  }) : sourceColorArgb = sourceColorHct.toInt(),
       errorPalette = errorPalette ?? TonalPalette.fromHueAndChroma(25.0, 84.0);

  DynamicScheme.fromVariant({
    required this.sourceColorHct,
    required this.isDark,
    required this.contrastLevel,
    required this.specVersion,
    required this.platform,
    required this.variant,
    TonalPalette? primaryPalette,
    TonalPalette? secondaryPalette,
    TonalPalette? tertiaryPalette,
    TonalPalette? neutralPalette,
    TonalPalette? neutralVariantPalette,
    TonalPalette? errorPalette,
  }) : sourceColorArgb = sourceColorHct.toInt(),
       primaryPalette =
           primaryPalette ??
           ColorSpecs.get(specVersion).getPrimaryPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       secondaryPalette =
           secondaryPalette ??
           ColorSpecs.get(specVersion).getSecondaryPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       tertiaryPalette =
           tertiaryPalette ??
           ColorSpecs.get(specVersion).getTertiaryPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       neutralPalette =
           neutralPalette ??
           ColorSpecs.get(specVersion).getNeutralPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       neutralVariantPalette =
           neutralVariantPalette ??
           ColorSpecs.get(specVersion).getNeutralVariantPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       errorPalette =
           errorPalette ??
           ColorSpecs.get(specVersion).getErrorPalette(
             variant,
             sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ) ??
           TonalPalette.fromHueAndChroma(25.0, 84.0);

  DynamicScheme.fromKeyColors({
    required this.sourceColorHct,
    required this.isDark,
    required this.contrastLevel,
    required this.specVersion,
    required this.platform,
    required this.variant,
    Hct? primaryPaletteKeyColor,
    Hct? secondaryPaletteKeyColor,
    Hct? tertiaryPaletteKeyColor,
    Hct? neutralPaletteKeyColor,
    Hct? neutralVariantPaletteKeyColor,
    Hct? errorPaletteKeyColor,
  }) : sourceColorArgb = sourceColorHct.toInt(),
       primaryPalette = ColorSpecs.get(specVersion).getPrimaryPalette(
         variant,
         primaryPaletteKeyColor ?? sourceColorHct,
         isDark,
         platform,
         contrastLevel,
       ),
       secondaryPalette = ColorSpecs.get(specVersion).getSecondaryPalette(
         variant,
         secondaryPaletteKeyColor ?? sourceColorHct,
         isDark,
         platform,
         contrastLevel,
       ),
       tertiaryPalette = ColorSpecs.get(specVersion).getTertiaryPalette(
         variant,
         tertiaryPaletteKeyColor ?? sourceColorHct,
         isDark,
         platform,
         contrastLevel,
       ),
       neutralPalette = ColorSpecs.get(specVersion).getNeutralPalette(
         variant,
         neutralPaletteKeyColor ?? sourceColorHct,
         isDark,
         platform,
         contrastLevel,
       ),
       neutralVariantPalette = ColorSpecs.get(specVersion)
           .getNeutralVariantPalette(
             variant,
             neutralVariantPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ),
       errorPalette =
           ColorSpecs.get(specVersion).getErrorPalette(
             variant,
             errorPaletteKeyColor ?? sourceColorHct,
             isDark,
             platform,
             contrastLevel,
           ) ??
           TonalPalette.fromHueAndChroma(25.0, 84.0);

  final int sourceColorArgb;
  final Hct sourceColorHct;
  final Variant variant;
  final bool isDark;
  final Platform platform;
  final double contrastLevel;
  final SpecVersion specVersion;
  final TonalPalette primaryPalette;
  final TonalPalette secondaryPalette;
  final TonalPalette tertiaryPalette;
  final TonalPalette neutralPalette;
  final TonalPalette neutralVariantPalette;
  final TonalPalette errorPalette;

  Hct getHct(DynamicColor dynamicColor) => dynamicColor.getHct(this);

  int getArgb(DynamicColor dynamicColor) => dynamicColor.getArgb(this);

  @override
  String toString() =>
      "Scheme: variant=${variant.name}, "
      "mode=${isDark ? "dark" : "light"}, "
      "platform=${platform.name}, "
      "contrastLevel=${contrastLevel.toStringAsFixed(1)}, "
      "seed=$sourceColorHct, "
      "specVersion=$specVersion";

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is DynamicScheme &&
            sourceColorArgb == other.sourceColorArgb &&
            sourceColorHct == other.sourceColorHct &&
            variant == other.variant &&
            isDark == other.isDark &&
            platform == other.platform &&
            contrastLevel == other.contrastLevel &&
            specVersion == other.specVersion &&
            primaryPalette == other.primaryPalette &&
            secondaryPalette == other.secondaryPalette &&
            tertiaryPalette == other.tertiaryPalette &&
            neutralPalette == other.neutralPalette &&
            neutralVariantPalette == other.neutralVariantPalette &&
            errorPalette == other.errorPalette;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sourceColorArgb,
    sourceColorHct,
    variant,
    isDark,
    platform,
    contrastLevel,
    specVersion,
    primaryPalette,
    secondaryPalette,
    tertiaryPalette,
    neutralPalette,
    neutralVariantPalette,
    errorPalette,
  );

  static DynamicScheme from(
    DynamicScheme other,
    bool isDark, [
    double? contrastLevel,
  ]) {
    return DynamicScheme(
      sourceColorHct: other.sourceColorHct,
      variant: other.variant,
      isDark: isDark,
      contrastLevel: contrastLevel ?? other.contrastLevel,
      platform: other.platform,
      specVersion: other.specVersion,
      primaryPalette: other.primaryPalette,
      secondaryPalette: other.secondaryPalette,
      tertiaryPalette: other.tertiaryPalette,
      neutralPalette: other.neutralPalette,
      neutralVariantPalette: other.neutralVariantPalette,
      errorPalette: other.errorPalette,
    );
  }

  static double getPiecewiseValue(
    Hct sourceColorHct,
    List<double> hueBreakpoints,
    List<double> hues,
  ) {
    final size = math.min(hueBreakpoints.length - 1, hues.length);
    final sourceHue = sourceColorHct.hue;
    for (int i = 0; i < size; i++) {
      if (sourceHue >= hueBreakpoints[i] && sourceHue < hueBreakpoints[i + 1]) {
        return MathUtils.sanitizeDegreesDouble(hues[i]);
      }
    }
    // No condition matched, return the source value.
    return sourceHue;
  }

  static double getRotatedHue(
    Hct sourceColorHct,
    List<double> hueBreakpoints,
    List<double> rotations,
  ) {
    double rotation = getPiecewiseValue(
      sourceColorHct,
      hueBreakpoints,
      rotations,
    );
    if (math.min(hueBreakpoints.length - 1, rotations.length) <= 0) {
      // No condition matched, return the source hue.
      rotation = 0.0;
    }
    return MathUtils.sanitizeDegrees(sourceColorHct.hue + rotation);
  }
}
