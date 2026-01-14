// ignore_for_file: recursive_getters

import 'dart:convert';
import 'dart:io';
import 'package:libmonet/material_color_utilities.dart';
import 'package:change_case/change_case.dart';
import 'package:libmonet/android_dynamic_colors.dart';
import 'package:mtb/src/cli.dart' show DynamicSchemes;
import 'package:mtb/src/color.dart';
import 'package:mtb/src/json.dart';

// const Map<SpecVersion, List<double>> _specVersionToContrastLevels = {
//   .spec2021: [-1.0, 0.0, 0.5, 1.0],
//   .spec2025: [0.0, 0.5, 1.0],
// };

const Map<SpecVersion, List<Variant>> _specVersionToVariants = {
  .spec2021: [
    .monochrome,
    .neutral,
    .tonalSpot,
    .vibrant,
    .expressive,
    .fidelity,
    .content,
    .rainbow,
    .fruitSalad,
  ],
  .spec2025: [.neutral, .tonalSpot, .vibrant, .expressive],
};

const Map<SpecVersion, List<Platform>> _specVersionToPlatforms = {
  .spec2021: [.phone],
  .spec2025: [.phone, .watch],
};

class SeedColors {
  const SeedColors({
    required this.sourceColor,
    this.primaryPaletteKeyColor,
    this.secondaryPaletteKeyColor,
    this.tertiaryPaletteKeyColor,
    this.neutralPaletteKeyColor,
    this.neutralVariantPaletteKeyColor,
    this.errorPaletteKeyColor,
  });

  final Color sourceColor;
  final Color? primaryPaletteKeyColor;
  final Color? secondaryPaletteKeyColor;
  final Color? tertiaryPaletteKeyColor;
  final Color? neutralPaletteKeyColor;
  final Color? neutralVariantPaletteKeyColor;
  final Color? errorPaletteKeyColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is SeedColors &&
          sourceColor == other.sourceColor &&
          primaryPaletteKeyColor == other.primaryPaletteKeyColor &&
          secondaryPaletteKeyColor == other.secondaryPaletteKeyColor &&
          tertiaryPaletteKeyColor == other.tertiaryPaletteKeyColor &&
          neutralPaletteKeyColor == other.neutralPaletteKeyColor &&
          neutralVariantPaletteKeyColor ==
              other.neutralVariantPaletteKeyColor &&
          errorPaletteKeyColor == other.errorPaletteKeyColor;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sourceColor,
    primaryPaletteKeyColor,
    secondaryPaletteKeyColor,
    tertiaryPaletteKeyColor,
    neutralPaletteKeyColor,
    neutralVariantPaletteKeyColor,
    errorPaletteKeyColor,
  );
}

const Map<String, SeedColors> seedColorsByName = {
  "baseline": SeedColors(sourceColor: Color.argb(0xFF6750A4)),
  "nowinandroid": SeedColors(
    sourceColor: Color.argb(0xFF8C4190),
    primaryPaletteKeyColor: Color.argb(0xFF8C4190),
    secondaryPaletteKeyColor: Color.argb(0xFFFF8456),
    tertiaryPaletteKeyColor: Color.argb(0xFFB3E9FF),
    neutralPaletteKeyColor: Color.argb(0xFF201A1B),
  ),
  "obtainium": SeedColors(sourceColor: Color.argb(0xFF6438B5)),
};

final MaterialDynamicColors _mdc = MaterialDynamicColors();
final AndroidDynamicColors _adc = AndroidDynamicColors();

final List<DynamicColor> _materialDynamicColors = <DynamicColor>[
  _mdc.primaryPaletteKeyColor,
  _mdc.secondaryPaletteKeyColor,
  _mdc.tertiaryPaletteKeyColor,
  _mdc.neutralPaletteKeyColor,
  _mdc.neutralVariantPaletteKeyColor,
  _mdc.errorPaletteKeyColor,
  _mdc.background,
  _mdc.onBackground,
  _mdc.surface,
  _mdc.surfaceDim,
  _mdc.surfaceBright,
  _mdc.surfaceContainerLowest,
  _mdc.surfaceContainerLow,
  _mdc.surfaceContainer,
  _mdc.surfaceContainerHigh,
  _mdc.surfaceContainerHighest,
  _mdc.onSurface,
  _mdc.surfaceVariant,
  _mdc.onSurfaceVariant,
  _mdc.outline,
  _mdc.outlineVariant,
  _mdc.inverseSurface,
  _mdc.inverseOnSurface,
  _mdc.shadow,
  _mdc.scrim,
  _mdc.surfaceTint,
  _mdc.primary,
  _mdc.primaryDim,
  _mdc.onPrimary,
  _mdc.primaryContainer,
  _mdc.onPrimaryContainer,
  _mdc.primaryFixed,
  _mdc.primaryFixedDim,
  _mdc.onPrimaryFixed,
  _mdc.onPrimaryFixedVariant,
  _mdc.inversePrimary,
  _mdc.secondary,
  _mdc.secondaryDim,
  _mdc.onSecondary,
  _mdc.secondaryContainer,
  _mdc.onSecondaryContainer,
  _mdc.secondaryFixed,
  _mdc.secondaryFixedDim,
  _mdc.onSecondaryFixed,
  _mdc.onSecondaryFixedVariant,
  _mdc.tertiary,
  _mdc.tertiaryDim,
  _mdc.onTertiary,
  _mdc.tertiaryContainer,
  _mdc.onTertiaryContainer,
  _mdc.tertiaryFixed,
  _mdc.tertiaryFixedDim,
  _mdc.onTertiaryFixed,
  _mdc.onTertiaryFixedVariant,
  _mdc.error,
  _mdc.errorDim,
  _mdc.onError,
  _mdc.errorContainer,
  _mdc.onErrorContainer,
];

final List<DynamicColor> _androidOnlyDynamicColors = <DynamicColor>[
  _mdc.controlActivated,
  _mdc.controlNormal,
  _mdc.controlHighlight,
  _mdc.textPrimaryInverse,
  _mdc.textSecondaryAndTertiaryInverse,
  _mdc.textPrimaryInverseDisableOnly,
  _mdc.textSecondaryAndTertiaryInverseDisabled,
  _mdc.textHintInverse,
];

final List<DynamicColor> _androidCustomDynamicColors = [
  _adc.widgetBackground,
  _adc.clockHour,
  _adc.clockMinute,
  _adc.clockSecond,
  _adc.weatherTemp,
  _adc.themeApp,
  _adc.onThemeApp,
  _adc.themeAppRing,
  _adc.themeNotif,
  _adc.brandA,
  _adc.brandB,
  _adc.brandC,
  _adc.brandD,
  _adc.underSurface,
  _adc.shadeActive,
  _adc.onShadeActive,
  _adc.onShadeActiveVariant,
  _adc.shadeInactive,
  _adc.onShadeInactive,
  _adc.onShadeInactiveVariant,
  _adc.shadeDisabled,
  _adc.overviewBackground,
];

final List<DynamicColor> _allDynamicColors = <DynamicColor>[
  ..._materialDynamicColors,
  ..._androidOnlyDynamicColors,
  ..._androidCustomDynamicColors,
];

void main() async {
  final futures = <Future<File>>[];
  for (final entry in seedColorsByName.entries) {
    final name = entry.key;
    final seedColors = entry.value;
    for (final specVersion in SpecVersion.values) {
      final variants = _specVersionToVariants[specVersion] ?? const [];
      for (final variant in variants) {
        final platforms = _specVersionToPlatforms[specVersion] ?? const [];
        for (final platform in platforms) {
          final schemes = DynamicSchemes.fromKeyColors(
            sourceColor: seedColors.sourceColor,
            primary: seedColors.primaryPaletteKeyColor,
            secondary: seedColors.secondaryPaletteKeyColor,
            tertiary: seedColors.tertiaryPaletteKeyColor,
            neutral: seedColors.neutralPaletteKeyColor,
            neutralVariant: seedColors.neutralVariantPaletteKeyColor,
            error: seedColors.errorPaletteKeyColor,
            variant: variant,
            specVersion: specVersion,
            platform: platform,
          );
          final data = Figma(
            description:
                "TYPE: CUSTOM\n"
                "Material Theme Builder export",
            seed: seedColors.sourceColor,
            coreColors: FigmaCoreColors(
              primary:
                  seedColors.primaryPaletteKeyColor ?? seedColors.sourceColor,
              secondary: seedColors.secondaryPaletteKeyColor,
              tertiary: seedColors.tertiaryPaletteKeyColor,
              neutral: seedColors.neutralPaletteKeyColor,
              neutralVariant: seedColors.neutralVariantPaletteKeyColor,
              error: seedColors.errorPaletteKeyColor,
            ),
            extendedColors: const [],
            schemes: schemes.toFigmaSchemes(),
            palettes: const FigmaPalettes(),
          );
          final json = data.toJson();
          final encoder = JsonEncoder.withIndent(" " * 2);
          final encoded = encoder.convert(json);
          final fileName =
              "${_buildNamedDescriptor(name: name, variant: variant, specVersion: specVersion, platform: platform)}.json";

          final path = "./example/figma/$fileName";
          final file = File(path);
          print("Writing: $path");
          final future = file
              .create(recursive: true)
              .then((file) => file.writeAsString(encoded));
          futures.add(future);

          final css = StringBuffer();

          void write(String selector, DynamicScheme scheme) {
            css.writeln("$selector {");
            for (final dynamicColor in _allDynamicColors) {
              final variableName =
                  "md-sys-color-${dynamicColor.name.toKebabCase()}";
              final variableProperty = "--$variableName";
              final variableValue =
                  "#${Color.argb(dynamicColor.getArgb(scheme)).hex}";
              css.writeln("  $variableProperty: $variableValue;");
            }
            css.writeln("}");
          }

          write(".light", schemes.light);
          write(".light-medium-contrast", schemes.lightMediumContrast);
          write(".light-high-contrast", schemes.lightHighContrast);
          write(".dark", schemes.dark);
          write(".dark-medium-contrast", schemes.darkMediumContrast);
          write(".dark-high-contrast", schemes.darkHighContrast);

          final cssContents = css.toString();
          final cssFileName =
              "${_buildNamedDescriptor(name: name, variant: variant, specVersion: specVersion, platform: platform)}.css";
          final cssPath = "./example/css/$cssFileName";
          final cssFile = File(cssPath);
          print("Writing: $cssPath");
          final cssFuture = cssFile
              .create(recursive: true)
              .then((file) => file.writeAsString(cssContents));
          futures.add(cssFuture);
        }
      }
    }
  }
  await Future.wait(futures);
}

String _buildDescriptor({
  required Variant variant,
  required SpecVersion specVersion,
  required Platform platform,
}) =>
    "${variant.toFlatCase()}_${specVersion.toFlatCase()}_${platform.toFlatCase()}";

String _buildNamedDescriptor({
  required String name,
  required Variant variant,
  required SpecVersion specVersion,
  required Platform platform,
}) =>
    "${name}_${_buildDescriptor(variant: variant, specVersion: specVersion, platform: platform)}";

extension on Variant {
  String toFlatCase() => switch (this) {
    .monochrome => "monochrome",
    .neutral => "neutral",
    .tonalSpot => "tonalspot",
    .vibrant => "vibrant",
    .expressive => "expressive",
    .fidelity => "fidelity",
    .content => "content",
    .rainbow => "rainbow",
    .fruitSalad => "fruitsalad",
  };
}

extension on SpecVersion {
  String toFlatCase() => switch (this) {
    .spec2021 => "2021",
    .spec2025 => "2025",
  };
}

extension on Platform {
  String toFlatCase() => switch (this) {
    .phone => "phone",
    .watch => "watch",
  };
}
