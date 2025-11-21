// ignore_for_file: recursive_getters

import 'dart:collection';

import 'package:material_color_utilities/material_color_utilities.dart';

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
