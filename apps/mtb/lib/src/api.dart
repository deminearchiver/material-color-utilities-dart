import 'package:material_color_utilities/material_color_utilities.dart';
import 'cli.dart' show DynamicSchemes;

// Map<String, Object?> generateJson({}) {

// }

abstract class Format {
  String serialize();
}

class FormatJsonLegacy {}
