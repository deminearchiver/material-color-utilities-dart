import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';

/// A loud theme, colorfulness is maximum for Primary palette, increased for others.
///
/// A Dynamic Color theme that maxes out colorfulness at each position in the
/// Primary Tonal Palette.
class SchemeVibrant extends DynamicScheme {
  SchemeVibrant({
    required super.sourceColorHct,
    required super.isDark,
    required super.contrastLevel,
    super.specVersion = DynamicScheme.defaultSpecVersion,
    super.platform = DynamicScheme.defaultPlatform,
  }) : super.fromVariant(variant: Variant.vibrant);
}
