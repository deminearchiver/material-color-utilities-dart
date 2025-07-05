import 'package:material_color_utilities/material_color_utilities.dart';

const colors = MaterialDynamicColors();
final allDynamicColors = colors.allDynamicColors;

void main() {
  final scheme = DynamicScheme.fromPalettesOrKeyColors(
    isDark: false,
    variant: Variant.tonalSpot,
    platform: Platform.phone,
    specVersion: SpecVersion.spec2025,
  );
  for (final dynamicColor in allDynamicColors) {
    final argb = dynamicColor.getArgb(scheme);
    print("${dynamicColor.name}: ${argb.toRadixString(16)}");
  }
}
