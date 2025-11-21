// ignore_for_file: recursive_getters

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:change_case/change_case.dart';
import 'package:mtb/src/cli.dart' show DynamicSchemes;
import 'package:mtb/src/color.dart';
import 'package:mtb/src/json.dart';

// const Map<SpecVersion, List<double>> _specVersionToContrastLevels = {
//   SpecVersion.spec2021: [-1.0, 0.0, 0.5, 1.0],
//   SpecVersion.spec2025: [0.0, 0.5, 1.0],
// };

const Map<SpecVersion, List<Variant>> _specVersionToVariants = {
  SpecVersion.spec2021: [
    Variant.monochrome,
    Variant.neutral,
    Variant.tonalSpot,
    Variant.vibrant,
    Variant.expressive,
    Variant.fidelity,
    Variant.content,
    Variant.rainbow,
    Variant.fruitSalad,
  ],
  SpecVersion.spec2025: [
    Variant.neutral,
    Variant.tonalSpot,
    Variant.vibrant,
    Variant.expressive,
  ],
};

const Map<SpecVersion, List<Platform>> _specVersionToPlatforms = {
  SpecVersion.spec2021: [Platform.phone],
  SpecVersion.spec2025: [Platform.phone, Platform.watch],
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
  bool operator ==(Object other) {
    return identical(this, other) ||
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
  }

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
};

final MaterialDynamicColors _mdc = const MaterialDynamicColors();
final AndroidCustomDynamicColors _adc = AndroidCustomDynamicColors();

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
  final List<Future<File>> futures = <Future<File>>[];
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
    Variant.monochrome => "monochrome",
    Variant.neutral => "neutral",
    Variant.tonalSpot => "tonalspot",
    Variant.vibrant => "vibrant",
    Variant.expressive => "expressive",
    Variant.fidelity => "fidelity",
    Variant.content => "content",
    Variant.rainbow => "rainbow",
    Variant.fruitSalad => "fruitsalad",
  };
}

extension on SpecVersion {
  String toFlatCase() => switch (this) {
    SpecVersion.spec2021 => "2021",
    SpecVersion.spec2025 => "2025",
  };
}

extension on Platform {
  String toFlatCase() => switch (this) {
    Platform.phone => "phone",
    Platform.watch => "watch",
  };
}

final class AndroidCustomDynamicColors {
  AndroidCustomDynamicColors();

  final MaterialDynamicColors _mMdc = const MaterialDynamicColors();

  // CLOCK COLORS
  DynamicColor get widgetBackground => DynamicColor(
    name: "widget_background",
    palette: (s) => s.secondaryPalette,
    tone: (s) => s.isDark ? 20.0 : 95.0,
    isBackground: true,
  );

  DynamicColor get clockHour => DynamicColor(
    name: "clock_hour",
    palette: (s) => s.isDark ? s.primaryPalette : s.secondaryPalette,
    tone: (s) => s.isDark ? 80.0 : 30.0,
    isBackground: false,
    background: (s) => widgetBackground,
    contrastCurve: (s) => const ContrastCurve(4.0, 4.0, 5.0, 15.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: clockHour,
      roleB: clockMinute,
      delta: 10.0,
      polarity: TonePolarity.darker,
      constraint: DeltaConstraint.farther,
    ),
  );

  DynamicColor get clockMinute => DynamicColor(
    name: "clock_minute",
    palette: (s) => s.primaryPalette,
    tone: (s) => s.isDark ? 90.0 : 40.0,
    isBackground: false,
    background: (s) => widgetBackground,
    contrastCurve: (s) => const ContrastCurve(6.5, 6.5, 10.0, 15.0),
  );

  DynamicColor get clockSecond => DynamicColor(
    name: "clock_second",
    palette: (s) => s.tertiaryPalette,
    tone: (s) => s.isDark ? 90.0 : 40.0,
    isBackground: false,
    background: (s) => widgetBackground,
    // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
    contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
  );

  DynamicColor get weatherTemp => DynamicColor(
    name: "weather_temp",
    palette: (s) => s.primaryPalette,
    tone: (s) => s.isDark ? 80.0 : 40.0,
    isBackground: false,
    background: (s) => widgetBackground,
    // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
    contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
  );
  // THEME APP ICONS
  DynamicColor get themeApp => DynamicColor(
    name: "theme_app",
    palette: (s) => s.isDark ? s.secondaryPalette : s.primaryPalette,
    tone: (s) => s.isDark ? 20.0 : 90.0,
    isBackground: true,
  );

  DynamicColor get onThemeApp => DynamicColor(
    name: "on_theme_app",
    palette: (s) => s.primaryPalette,
    tone: (s) => s.isDark ? 80.0 : 30.0,
    isBackground: false,
    background: (s) => themeApp,
    contrastCurve: (s) => const ContrastCurve(3.0, 3.0, 7.0, 10.0),
  );

  DynamicColor get themeAppRing => DynamicColor(
    name: "theme_app_ring",
    palette: (s) => s.primaryPalette,
    tone: (s) => 70.0,
    isBackground: true,
  );

  DynamicColor get themeNotif => DynamicColor(
    name: "theme_notif",
    palette: (s) => s.tertiaryPalette,
    tone: (s) => 80.0,
    background: (s) => themeAppRing,
    contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: themeNotif,
      roleB: themeAppRing,
      delta: 10.0,
      polarity: TonePolarity.relativeLighter,
      constraint: DeltaConstraint.farther,
    ),
  );

  // SUPER G COLORS
  DynamicColor get brandA => DynamicColor(
    name: "brand_a",
    palette: (s) => s.primaryPalette,
    tone: (s) => s.isDark ? 80.0 : 40.0,
    background: (s) => _mMdc.surfaceContainerLow,
    contrastCurve: (s) => s.isDark
        ? const ContrastCurve(10.0, 10.0, 12.0, 13.0)
        : const ContrastCurve(6.0, 6.0, 9.0, 12.0),
  );

  DynamicColor get brandB => DynamicColor(
    name: "brand_b",
    palette: (s) => s.secondaryPalette,
    tone: (s) => s.isDark ? 98.0 : 70.0,
    background: (s) => _mMdc.surfaceContainerLow,
    contrastCurve: (s) => s.isDark
        ? const ContrastCurve(16.0, 16.0, 16.5, 17.0)
        : const ContrastCurve(2.0, 2.0, 3.0, 4.5),
  );

  DynamicColor get brandC => DynamicColor(
    name: "brand_c",
    palette: (s) => s.primaryPalette,
    tone: (s) => s.isDark ? 60.0 : 50.0,
    background: (s) => _mMdc.surfaceContainerLow,
    contrastCurve: (s) => s.isDark
        ? const ContrastCurve(6.0, 6.0, 9.0, 11.0)
        : const ContrastCurve(4.0, 4.0, 7.0, 8.0),
  );

  DynamicColor get brandD => DynamicColor(
    name: "brand_d",
    palette: (s) => s.tertiaryPalette,
    tone: (s) => s.isDark ? 90.0 : 59.0,
    background: (s) => _mMdc.surfaceContainerLow,
    contrastCurve: (s) => s.isDark
        ? const ContrastCurve(13.0, 13.0, 14.0, 15.0)
        : const ContrastCurve(3.0, 3.0, 4.5, 6.0),
  );

  // QUICK SETTING TILES
  DynamicColor get underSurface => DynamicColor(
    name: "under_surface",
    palette: (s) => s.primaryPalette,
    tone: (s) => 0.0,
    isBackground: true,
  );

  DynamicColor get shadeActive => DynamicColor(
    name: "shade_active",
    palette: (s) => s.primaryPalette,
    tone: (s) => 90.0,
    isBackground: true,
    background: (s) => underSurface,
    contrastCurve: (s) => const ContrastCurve(3.0, 3.0, 4.5, 7.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: shadeActive,
      roleB: shadeInactive,
      delta: 30.0,
      polarity: TonePolarity.lighter,
      constraint: DeltaConstraint.farther,
    ),
  );

  DynamicColor get onShadeActive => DynamicColor(
    name: "on_shade_active",
    palette: (s) => s.primaryPalette,
    tone: (s) => 10.0,
    isBackground: false,
    background: (s) => shadeActive,
    contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: onShadeActive,
      roleB: onShadeActiveVariant,
      delta: 20.0,
      polarity: TonePolarity.relativeLighter,
      constraint: DeltaConstraint.farther,
    ),
  );

  DynamicColor get onShadeActiveVariant => DynamicColor(
    name: "on_shade_active_variant",
    palette: (s) => s.primaryPalette,
    tone: (s) => 30.0,
    isBackground: false,
    background: (s) => shadeActive,
    contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
  );

  DynamicColor get shadeInactive => DynamicColor(
    name: "shade_inactive",
    palette: (s) => s.neutralPalette,
    tone: (s) => 20.0,
    isBackground: true,
    background: (s) => underSurface,
    contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: shadeInactive,
      roleB: shadeDisabled,
      delta: 15.0,
      polarity: TonePolarity.lighter,
      constraint: DeltaConstraint.farther,
    ),
  );

  DynamicColor get onShadeInactive => DynamicColor(
    name: "on_shade_inactive",
    palette: (s) => s.neutralVariantPalette,
    tone: (s) => 90.0,
    isBackground: false,
    background: (s) => shadeInactive,
    contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
    toneDeltaPair: (s) => ToneDeltaPair(
      roleA: onShadeInactive,
      roleB: onShadeInactiveVariant,
      delta: 10.0,
      polarity: TonePolarity.relativeLighter,
      constraint: DeltaConstraint.nearer,
    ),
  );

  DynamicColor get onShadeInactiveVariant => DynamicColor(
    name: "on_shade_inactive_variant",
    palette: (s) => s.neutralVariantPalette,
    tone: (s) => 80.0,
    isBackground: false,
    background: (s) => shadeInactive,
    contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
  );

  DynamicColor get shadeDisabled => DynamicColor(
    name: "shade_disabled",
    palette: (s) => s.neutralPalette,
    tone: (s) => 4.0,
    isBackground: false,
    background: (s) => underSurface,
    contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
  );

  DynamicColor get overviewBackground => DynamicColor(
    name: "overview_background",
    palette: (s) => s.neutralVariantPalette,
    tone: (s) => s.isDark ? 35.0 : 80.0,
    isBackground: true,
  );

  late final List<DynamicColor Function()> allColors = UnmodifiableListView([
    () => widgetBackground,
    () => clockHour,
    () => clockMinute,
    () => clockSecond,
    () => weatherTemp,
    () => themeApp,
    () => onThemeApp,
    () => themeAppRing,
    () => themeNotif,
    () => brandA,
    () => brandB,
    () => brandC,
    () => brandD,
    () => underSurface,
    () => shadeActive,
    () => onShadeActive,
    () => onShadeActiveVariant,
    () => shadeInactive,
    () => onShadeInactive,
    () => onShadeInactiveVariant,
    () => shadeDisabled,
    () => overviewBackground,
  ]);
}
