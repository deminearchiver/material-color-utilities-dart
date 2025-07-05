import 'package:material_color_utilities/material_color_utilities.dart';

class AndroidDynamicColors {
  const AndroidDynamicColors();

  static const MaterialDynamicColors _dynamicColors = MaterialDynamicColors();

  DynamicColor widgetBackground() {
    return DynamicColor.fromPalette(
      name: "widget_background",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 20.0 : 95.0,
      isBackground: true,
    );
  }

  List<DynamicColor> get allDynamicColors => [widgetBackground()];
}
