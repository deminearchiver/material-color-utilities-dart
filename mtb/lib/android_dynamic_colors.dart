// ignore_for_file: recursive_getters

import 'dart:collection';

import 'package:material_color_utilities/material_color_utilities.dart';

final class AndroidCustomDynamicColors {
  AndroidCustomDynamicColors();

  final MaterialDynamicColors _mMdc = const MaterialDynamicColors();

  // CLOCK COLORS
  DynamicColor get widgetBackground {
    final color2021 = DynamicColor(
      name: "widget_background",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 20.0 : 95.0,
      isBackground: true,
    );
    final color2025 = DynamicColor(
      name: "widget_background",
      palette: (s) => s.secondaryPalette,
      tone: (s) => s.isDark ? 20.0 : 95.0,
      isBackground: true,
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  DynamicColor get clockHour {
    final color2021 = DynamicColor(
      name: "clock_hour",
      palette: (s) => s.secondaryPalette,
      tone: (s) => s.isDark ? 60.0 : 30.0,
      isBackground: false,
      background: (s) => widgetBackground,
      contrastCurve: (s) => const ContrastCurve(4.0, 4.0, 5.0, 15.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: clockHour,
        roleB: clockMinute,
        delta: 10.0,
        polarity: .darker,
        stayTogether: false,
      ),
    );
    final color2025 = DynamicColor(
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
        polarity: .darker,
        constraint: .farther,
      ),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  // TODO: merge into a single declaration
  DynamicColor get clockMinute {
    final color2021 = DynamicColor(
      name: "clock_minute",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 90.0 : 40.0,
      isBackground: false,
      background: (s) => widgetBackground,
      contrastCurve: (s) => const ContrastCurve(6.5, 6.5, 10.0, 15.0),
    );
    final color2025 = DynamicColor(
      name: "clock_minute",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 90.0 : 40.0,
      isBackground: false,
      background: (s) => widgetBackground,
      contrastCurve: (s) => const ContrastCurve(6.5, 6.5, 10.0, 15.0),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  // TODO: merge into a single declaration
  DynamicColor get clockSecond {
    final color2021 = DynamicColor(
      name: "clock_second",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => s.isDark ? 90.0 : 40.0,
      isBackground: false,
      background: (s) => widgetBackground,
      // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
      contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
    );
    final color2025 = DynamicColor(
      name: "clock_second",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => s.isDark ? 90.0 : 40.0,
      isBackground: false,
      background: (s) => widgetBackground,
      // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
      contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  DynamicColor get weatherTemp {
    final color2021 = DynamicColor(
      name: "weather_temp",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 55.0,
      isBackground: false,
      background: (s) => widgetBackground,
      // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
      contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
    );
    final color2025 = DynamicColor(
      name: "weather_temp",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      isBackground: false,
      background: (s) => widgetBackground,
      // TODO: investigate if 70 should be changed to 7 (maybe a typo?)
      contrastCurve: (s) => const ContrastCurve(5.0, 5.0, 70.0, 11.0),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  // THEME APP ICONS
  DynamicColor get themeApp {
    final color2021 = DynamicColor(
      name: "theme_app",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 30.0 : 90.0,
      isBackground: true,
    );
    final color2025 = DynamicColor(
      name: "theme_app",
      palette: (s) => s.isDark ? s.secondaryPalette : s.primaryPalette,
      tone: (s) => s.isDark ? 20.0 : 90.0,
      isBackground: true,
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  DynamicColor get onThemeApp {
    final color2021 = DynamicColor(
      name: "on_theme_app",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      isBackground: false,
      background: (s) => themeApp,
      contrastCurve: (s) => const ContrastCurve(3.0, 3.0, 7.0, 10.0),
    );
    final color2025 = DynamicColor(
      name: "on_theme_app",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 30.0,
      isBackground: false,
      background: (s) => themeApp,
      contrastCurve: (s) => const ContrastCurve(3.0, 3.0, 7.0, 10.0),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  DynamicColor get themeAppRing {
    final color2021 = DynamicColor(
      name: "theme_app_ring",
      palette: (s) => s.primaryPalette,
      tone: (s) => 70.0,
      isBackground: true,
    );
    final color2025 = DynamicColor(
      name: "theme_app_ring",
      palette: (s) => s.primaryPalette,
      tone: (s) => 70.0,
      isBackground: true,
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  DynamicColor get themeNotif {
    // TODO: figure out a replacement for TonePolarity.nearer
    final color2021 = DynamicColor(
      name: "theme_notif",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => 80.0,
      isBackground: false,
      background: (s) => themeAppRing,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: themeNotif,
        roleB: themeAppRing,
        delta: 10.0,
        polarity: .relativeLighter,
        constraint: .farther,
      ),
    );
    final color2025 = DynamicColor(
      name: "theme_notif",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => 80.0,
      isBackground: false,
      background: (s) => themeAppRing,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: themeNotif,
        roleB: themeAppRing,
        delta: 10.0,
        polarity: .relativeLighter,
        constraint: .farther,
      ),
    );
    return color2021.extendSpecVersion(.spec2025, color2025);
  }

  // SUPER G COLORS
  DynamicColor get brandA {
    final color2025 = DynamicColor(
      name: "brand_a",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      background: (s) => _mMdc.surfaceContainerLow,
      contrastCurve: (s) => s.isDark
          ? const ContrastCurve(10.0, 10.0, 12.0, 13.0)
          : const ContrastCurve(6.0, 6.0, 9.0, 12.0),
    );
    return color2025;
  }

  DynamicColor get brandB {
    final color2025 = DynamicColor(
      name: "brand_b",
      palette: (s) => s.secondaryPalette,
      tone: (s) => s.isDark ? 98.0 : 70.0,
      background: (s) => _mMdc.surfaceContainerLow,
      contrastCurve: (s) => s.isDark
          ? const ContrastCurve(16.0, 16.0, 16.5, 17.0)
          : const ContrastCurve(2.0, 2.0, 3.0, 4.5),
    );
    return color2025;
  }

  DynamicColor get brandC {
    final color2025 = DynamicColor(
      name: "brand_c",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 60.0 : 50.0,
      background: (s) => _mMdc.surfaceContainerLow,
      contrastCurve: (s) => s.isDark
          ? const ContrastCurve(6.0, 6.0, 9.0, 11.0)
          : const ContrastCurve(4.0, 4.0, 7.0, 8.0),
    );
    return color2025;
  }

  DynamicColor get brandD {
    final color2025 = DynamicColor(
      name: "brand_d",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => s.isDark ? 90.0 : 59.0,
      background: (s) => _mMdc.surfaceContainerLow,
      contrastCurve: (s) => s.isDark
          ? const ContrastCurve(13.0, 13.0, 14.0, 15.0)
          : const ContrastCurve(3.0, 3.0, 4.5, 6.0),
    );
    return color2025;
  }

  // QUICK SETTING TILES
  DynamicColor get underSurface {
    final color2025 = DynamicColor(
      name: "under_surface",
      palette: (s) => s.primaryPalette,
      tone: (s) => 0.0,
      isBackground: true,
    );
    return color2025;
  }

  DynamicColor get shadeActive {
    final color2025 = DynamicColor(
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
        polarity: .lighter,
        constraint: .farther,
      ),
    );
    return color2025;
  }

  DynamicColor get onShadeActive {
    final color2025 = DynamicColor(
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
        polarity: .relativeLighter,
        constraint: .farther,
      ),
    );
    return color2025;
  }

  DynamicColor get onShadeActiveVariant {
    final color2025 = DynamicColor(
      name: "on_shade_active_variant",
      palette: (s) => s.primaryPalette,
      tone: (s) => 30.0,
      isBackground: false,
      background: (s) => shadeActive,
      contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
    );
    return color2025;
  }

  DynamicColor get shadeInactive {
    final color2025 = DynamicColor(
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
        polarity: .lighter,
        constraint: .farther,
      ),
    );
    return color2025;
  }

  DynamicColor get onShadeInactive {
    final color2025 = DynamicColor(
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
        polarity: .relativeLighter,
        constraint: .nearer,
      ),
    );
    return color2025;
  }

  DynamicColor get onShadeInactiveVariant {
    final color2025 = DynamicColor(
      name: "on_shade_inactive_variant",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => 80.0,
      isBackground: false,
      background: (s) => shadeInactive,
      contrastCurve: (s) => const ContrastCurve(4.5, 4.5, 7.0, 11.0),
    );
    return color2025;
  }

  DynamicColor get shadeDisabled {
    final color2025 = DynamicColor(
      name: "shade_disabled",
      palette: (s) => s.neutralPalette,
      tone: (s) => 4.0,
      isBackground: false,
      background: (s) => underSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 1.0, 1.0),
    );
    return color2025;
  }

  DynamicColor get overviewBackground {
    final color2025 = DynamicColor(
      name: "overview_background",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 35.0 : 80.0,
      isBackground: true,
    );
    return color2025;
  }

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
