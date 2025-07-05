import '../dynamiccolor/dynamic_scheme.dart';
import '../dynamiccolor/variant.dart';

/// A calm theme, sedated colors that aren't particularly chromatic.
///
/// A Dynamic Color theme with low to medium colorfulness and a Tertiary
/// TonalPalette with a hue related to the source color.
///
/// The default Material You theme on Android 12 and 13.
class SchemeTonalSpot extends DynamicScheme {
  SchemeTonalSpot({
    required super.sourceColorHct,
    required super.isDark,
    required super.contrastLevel,
    super.specVersion = DynamicScheme.defaultSpecVersion,
    super.platform = DynamicScheme.defaultPlatform,
  }) : super.fromVariant(variant: Variant.tonalSpot);
}
