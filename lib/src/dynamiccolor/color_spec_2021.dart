import 'dart:math' as math;

import '../utils/math_utils.dart';
import '../hct/hct.dart';
import '../contrast/contrast.dart';
import '../dislike/dislike_analyzer.dart';
import '../temperature/temperature_cache.dart';
import '../palettes/tonal_palette.dart';

import 'color_spec.dart';
import 'contrast_curve.dart';
import 'dynamic_color.dart';
import 'dynamic_scheme.dart';
import 'tone_delta_pair.dart';
import 'variant.dart';

class ColorSpec2021 implements ColorSpec {
  const ColorSpec2021();

  static bool _isMonochrome(DynamicScheme scheme) {
    return scheme.variant == Variant.monochrome;
  }

  static bool _isFidelity(DynamicScheme scheme) {
    return scheme.variant == Variant.fidelity ||
        scheme.variant == Variant.content;
  }

  static double _findDesiredChromaByTone(
    double hue,
    double chroma,
    double tone,
    bool byDecreasingTone,
  ) {
    double answer = tone;

    Hct closestToChroma = Hct.from(hue, chroma, tone);
    if (closestToChroma.chroma < chroma) {
      double chromaPeak = closestToChroma.chroma;
      while (closestToChroma.chroma < chroma) {
        answer += byDecreasingTone ? -1.0 : 1.0;
        Hct potentialSolution = Hct.from(hue, chroma, answer);
        if (chromaPeak > potentialSolution.chroma) {
          break;
        }
        if ((potentialSolution.chroma - chroma).abs() < 0.4) {
          break;
        }

        double potentialDelta = (potentialSolution.chroma - chroma).abs();
        double currentDelta = (closestToChroma.chroma - chroma).abs();
        if (potentialDelta < currentDelta) {
          closestToChroma = potentialSolution;
        }
        chromaPeak = math.max(chromaPeak, potentialSolution.chroma);
      }
    }

    return answer;
  }

  @override
  DynamicColor primaryPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "primary_palette_key_color",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.primaryPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor secondaryPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "secondary_palette_key_color",
      palette: (s) => s.secondaryPalette,
      tone: (s) => s.secondaryPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor tertiaryPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "tertiary_palette_key_color",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => s.tertiaryPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor neutralPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "neutral_palette_key_color",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.neutralPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor neutralVariantPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "neutral_variant_palette_key_color",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.neutralVariantPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor errorPaletteKeyColor() {
    return DynamicColor.fromPalette(
      name: "error_palette_key_color",
      palette: (s) => s.errorPalette,
      tone: (s) => s.errorPalette.keyColor.tone,
    );
  }

  @override
  DynamicColor background() {
    return DynamicColor.fromPalette(
      name: "background",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 6.0 : 98.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor onBackground() {
    return DynamicColor.fromPalette(
      name: "on_background",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 90.0 : 10.0,
      background: (s) => background(),
      contrastCurve: (s) => ContrastCurve(3.0, 3.0, 4.5, 7.0),
    );
  }

  @override
  DynamicColor surface() {
    return DynamicColor.fromPalette(
      name: "surface",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 6.0 : 98.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceDim() {
    return DynamicColor.fromPalette(
      name: "surface_dim",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? 6.0
          : const ContrastCurve(87.0, 87.0, 80.0, 75.0).get(s.contrastLevel),
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceBright() {
    return DynamicColor.fromPalette(
      name: "surface_bright",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(24.0, 24.0, 29.0, 34.0).get(s.contrastLevel)
          : 98.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceContainerLowest() {
    return DynamicColor.fromPalette(
      name: "surface_container_lowest",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(4.0, 4.0, 2.0, 0.0).get(s.contrastLevel)
          : 100.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceContainerLow() {
    return DynamicColor.fromPalette(
      name: "surface_container_low",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(10.0, 10.0, 11.0, 12.0).get(s.contrastLevel)
          : const ContrastCurve(96.0, 96.0, 96.0, 95.0).get(s.contrastLevel),
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceContainer() {
    return DynamicColor.fromPalette(
      name: "surface_container",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(12.0, 12.0, 16.0, 20.0).get(s.contrastLevel)
          : const ContrastCurve(94.0, 94.0, 92.0, 90.0).get(s.contrastLevel),
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceContainerHigh() {
    return DynamicColor.fromPalette(
      name: "surface_container_high",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(17.0, 17.0, 21.0, 25.0).get(s.contrastLevel)
          : const ContrastCurve(92.0, 92.0, 88.0, 85.0).get(s.contrastLevel),
      isBackground: true,
    );
  }

  @override
  DynamicColor surfaceContainerHighest() {
    return DynamicColor.fromPalette(
      name: "surface_container_highest",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark
          ? const ContrastCurve(22.0, 22.0, 26.0, 30.0).get(s.contrastLevel)
          : const ContrastCurve(90.0, 90.0, 84.0, 80.0).get(s.contrastLevel),
      isBackground: true,
    );
  }

  @override
  DynamicColor onSurface() {
    return DynamicColor.fromPalette(
      name: "on_surface",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 90.0 : 10.0,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor surfaceVariant() {
    return DynamicColor.fromPalette(
      name: "surface_variant",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 30.0 : 90.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor onSurfaceVariant() {
    return DynamicColor.fromPalette(
      name: "on_surface_variant",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 80.0 : 30.0,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor inverseSurface() {
    return DynamicColor.fromPalette(
      name: "inverse_surface",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 90.0 : 20.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor inverseOnSurface() {
    return DynamicColor.fromPalette(
      name: "inverse_on_surface",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 20.0 : 95.0,
      background: (s) => inverseSurface(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor outline() {
    return DynamicColor.fromPalette(
      name: "outline",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 60.0 : 50.0,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.5, 3.0, 4.5, 7.0),
    );
  }

  @override
  DynamicColor outlineVariant() {
    return DynamicColor.fromPalette(
      name: "outline_variant",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 30.0 : 80.0,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
    );
  }

  @override
  DynamicColor shadow() {
    return DynamicColor.fromPalette(
      name: "shadow",
      palette: (s) => s.neutralPalette,
      tone: (s) => 0.0,
    );
  }

  @override
  DynamicColor scrim() {
    return DynamicColor.fromPalette(
      name: "scrim",
      palette: (s) => s.neutralPalette,
      tone: (s) => 0.0,
    );
  }

  @override
  DynamicColor surfaceTint() {
    return DynamicColor.fromPalette(
      name: "surface_tint",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor primary() {
    return DynamicColor.fromPalette(
      name: "primary",
      palette: (s) => s.primaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 100.0 : 0.0;
        }
        return s.isDark ? 80.0 : 40.0;
      },
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 7.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: primaryContainer(),
        roleB: primary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor? primaryDim() {
    return null;
  }

  @override
  DynamicColor onPrimary() {
    return DynamicColor.fromPalette(
      name: "on_primary",
      palette: (s) => s.primaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 10.0 : 90.0;
        }
        return s.isDark ? 20.0 : 100.0;
      },
      background: (s) => primary(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor primaryContainer() {
    return DynamicColor.fromPalette(
      name: "primary_container",
      palette: (s) => s.primaryPalette,
      tone: (s) {
        if (_isFidelity(s)) {
          return s.sourceColorHct.tone;
        }
        if (_isMonochrome(s)) {
          return s.isDark ? 85.0 : 25.0;
        }
        return s.isDark ? 30.0 : 90.0;
      },
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: primaryContainer(),
        roleB: primary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor onPrimaryContainer() {
    return DynamicColor.fromPalette(
      name: "on_primary_container",
      palette: (s) => s.primaryPalette,
      tone: (s) {
        if (_isFidelity(s)) {
          return DynamicColor.foregroundTone(primaryContainer().tone(s), 4.5);
        }
        if (_isMonochrome(s)) {
          return s.isDark ? 0.0 : 100.0;
        }
        return s.isDark ? 90.0 : 30.0;
      },
      background: (s) => primaryContainer(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor inversePrimary() {
    return DynamicColor.fromPalette(
      name: "inverse_primary",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 40.0 : 80.0,
      background: (s) => inverseSurface(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 7.0),
    );
  }

  @override
  DynamicColor secondary() {
    return DynamicColor.fromPalette(
      name: "secondary",
      palette: (s) => s.secondaryPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 7.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: secondaryContainer(),
        roleB: secondary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor? secondaryDim() {
    return null;
  }

  @override
  DynamicColor onSecondary() {
    return DynamicColor.fromPalette(
      name: "on_secondary",
      palette: (s) => s.secondaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 10.0 : 100.0;
        }
        return s.isDark ? 20.0 : 100.0;
      },
      background: (s) => secondary(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor secondaryContainer() {
    return DynamicColor.fromPalette(
      name: "secondary_container",
      palette: (s) => s.secondaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 30.0 : 85.0;
        }
        final double initialTone = s.isDark ? 30.0 : 90.0;
        if (!_isFidelity(s)) return initialTone;
        return _findDesiredChromaByTone(
          s.secondaryPalette.hue,
          s.secondaryPalette.chroma,
          initialTone,
          !s.isDark,
        );
      },
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: secondaryContainer(),
        roleB: secondary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor onSecondaryContainer() {
    return DynamicColor.fromPalette(
      name: "on_secondary_container",
      palette: (s) => s.secondaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 90.0 : 10.0;
        }
        if (!_isFidelity(s)) {
          return s.isDark ? 90.0 : 30.0;
        }
        return DynamicColor.foregroundTone(secondaryContainer().tone(s), 4.5);
      },
      background: (s) => secondaryContainer(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor tertiary() {
    return DynamicColor.fromPalette(
      name: "tertiary",
      palette: (s) => s.tertiaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 90.0 : 25.0;
        }
        return s.isDark ? 80.0 : 40.0;
      },
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 7.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: tertiaryContainer(),
        roleB: tertiary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor? tertiaryDim() {
    return null;
  }

  @override
  DynamicColor onTertiary() {
    return DynamicColor.fromPalette(
      name: "on_tertiary",
      palette: (s) => s.tertiaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 10.0 : 90.0;
        }
        return s.isDark ? 20.0 : 100.0;
      },
      background: (s) => tertiary(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor tertiaryContainer() {
    return DynamicColor.fromPalette(
      name: "tertiary_container",
      palette: (s) => s.tertiaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 60.0 : 49.0;
        }
        if (!_isFidelity(s)) {
          return s.isDark ? 30.0 : 90.0;
        }
        final proposedHct = s.tertiaryPalette.getHct(s.sourceColorHct.tone);
        return DislikeAnalyzer.fixIfDisliked(proposedHct).tone;
      },
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: tertiaryContainer(),
        roleB: tertiary(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor onTertiaryContainer() {
    return DynamicColor.fromPalette(
      name: "on_tertiary_container",
      palette: (s) => s.tertiaryPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 0.0 : 100.0;
        }
        if (!_isFidelity(s)) {
          return s.isDark ? 90.0 : 30.0;
        }
        return DynamicColor.foregroundTone(tertiaryContainer().tone(s), 4.5);
      },
      background: (s) => tertiaryContainer(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor error() {
    return DynamicColor.fromPalette(
      name: "error",
      palette: (s) => s.errorPalette,
      tone: (s) => s.isDark ? 80.0 : 40.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 7.0),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: errorContainer(),
        roleB: error(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor? errorDim() {
    return null;
  }

  @override
  DynamicColor onError() {
    return DynamicColor.fromPalette(
      name: "on_error",
      palette: (s) => s.errorPalette,
      tone: (s) => s.isDark ? 20.0 : 100.0,
      background: (s) => error(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor errorContainer() {
    return DynamicColor.fromPalette(
      name: "error_container",
      palette: (s) => s.errorPalette,
      tone: (s) => s.isDark ? 30.0 : 90.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: errorContainer(),
        roleB: error(),
        delta: 10.0,
        polarity: TonePolarity.relativeLighter,
        stayTogether: false,
        constraint: DeltaConstraint.nearer,
      ),
    );
  }

  @override
  DynamicColor onErrorContainer() {
    return DynamicColor.fromPalette(
      name: "on_error_container",
      palette: (s) => s.errorPalette,
      tone: (s) {
        if (_isMonochrome(s)) {
          return s.isDark ? 90.0 : 10.0;
        }
        return s.isDark ? 90.0 : 30.0;
      },
      background: (s) => errorContainer(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor primaryFixed() {
    return DynamicColor.fromPalette(
      name: "primary_fixed",
      palette: (s) => s.primaryPalette,
      tone: (s) => _isMonochrome(s) ? 40.0 : 90.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: primaryFixed(),
        roleB: primaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor primaryFixedDim() {
    return DynamicColor.fromPalette(
      name: "primary_fixed_dim",
      palette: (s) => s.primaryPalette,
      tone: (s) => _isMonochrome(s) ? 30.0 : 80.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: primaryFixed(),
        roleB: primaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor onPrimaryFixed() {
    return DynamicColor.fromPalette(
      name: "on_primary_fixed",
      palette: (s) => s.primaryPalette,
      tone: (s) => _isMonochrome(s) ? 100.0 : 10.0,
      background: (s) => primaryFixedDim(),
      secondBackground: (s) => primaryFixed(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor onPrimaryFixedVariant() {
    return DynamicColor.fromPalette(
      name: "on_primary_fixed_variant",
      palette: (s) => s.primaryPalette,
      tone: (s) => _isMonochrome(s) ? 90.0 : 30.0,
      background: (s) => primaryFixedDim(),
      secondBackground: (s) => primaryFixed(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor secondaryFixed() {
    return DynamicColor.fromPalette(
      name: "secondary_fixed",
      palette: (s) => s.secondaryPalette,
      tone: (s) => _isMonochrome(s) ? 80.0 : 90.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: secondaryFixed(),
        roleB: secondaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor secondaryFixedDim() {
    return DynamicColor.fromPalette(
      name: "secondary_fixed_dim",
      palette: (s) => s.secondaryPalette,
      tone: (s) => _isMonochrome(s) ? 70.0 : 80.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: secondaryFixed(),
        roleB: secondaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor onSecondaryFixed() {
    return DynamicColor.fromPalette(
      name: "on_secondary_fixed",
      palette: (s) => s.secondaryPalette,
      tone: (s) => 10.0,
      background: (s) => secondaryFixedDim(),
      secondBackground: (s) => secondaryFixed(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor onSecondaryFixedVariant() {
    return DynamicColor.fromPalette(
      name: "on_secondary_fixed_variant",
      palette: (s) => s.secondaryPalette,
      tone: (s) => _isMonochrome(s) ? 25.0 : 30.0,
      background: (s) => secondaryFixedDim(),
      secondBackground: (s) => secondaryFixed(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor tertiaryFixed() {
    return DynamicColor.fromPalette(
      name: "tertiary_fixed",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => _isMonochrome(s) ? 40.0 : 90.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: tertiaryFixed(),
        roleB: tertiaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor tertiaryFixedDim() {
    return DynamicColor.fromPalette(
      name: "tertiary_fixed_dim",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => _isMonochrome(s) ? 30.0 : 80.0,
      isBackground: true,
      background: highestSurface,
      contrastCurve: (s) => const ContrastCurve(1.0, 1.0, 3.0, 4.5),
      toneDeltaPair: (s) => ToneDeltaPair(
        roleA: tertiaryFixed(),
        roleB: tertiaryFixedDim(),
        delta: 10.0,
        polarity: TonePolarity.lighter,
        stayTogether: true,
      ),
    );
  }

  @override
  DynamicColor onTertiaryFixed() {
    return DynamicColor.fromPalette(
      name: "on_tertiary_fixed",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => _isMonochrome(s) ? 100.0 : 10.0,
      background: (s) => tertiaryFixedDim(),
      secondBackground: (s) => tertiaryFixed(),
      contrastCurve: (s) => const ContrastCurve(4.5, 7.0, 11.0, 21.0),
    );
  }

  @override
  DynamicColor onTertiaryFixedVariant() {
    return DynamicColor.fromPalette(
      name: "on_tertiary_fixed_variant",
      palette: (s) => s.tertiaryPalette,
      tone: (s) => _isMonochrome(s) ? 90.0 : 30.0,
      background: (s) => tertiaryFixedDim(),
      secondBackground: (s) => tertiaryFixed(),
      contrastCurve: (s) => const ContrastCurve(3.0, 4.5, 7.0, 11.0),
    );
  }

  @override
  DynamicColor controlActivated() {
    return DynamicColor.fromPalette(
      name: "control_activated",
      palette: (s) => s.primaryPalette,
      tone: (s) => s.isDark ? 30.0 : 90.0,
      isBackground: true,
    );
  }

  @override
  DynamicColor controlNormal() {
    return DynamicColor.fromPalette(
      name: "control_normal",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 80.0 : 30.0,
    );
  }

  @override
  DynamicColor controlHighlight() {
    return DynamicColor.fromPalette(
      name: "control_highlight",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 100.0 : 0.0,
      opacity: (s) => s.isDark ? 0.20 : 0.12,
    );
  }

  @override
  DynamicColor textPrimaryInverse() {
    return DynamicColor.fromPalette(
      name: "text_primary_inverse",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 10.0 : 90.0,
    );
  }

  @override
  DynamicColor textSecondaryAndTertiaryInverse() {
    return DynamicColor.fromPalette(
      name: "text_secondary_and_tertiary_inverse",
      palette: (s) => s.neutralVariantPalette,
      tone: (s) => s.isDark ? 30.0 : 80.0,
    );
  }

  @override
  DynamicColor textPrimaryInverseDisableOnly() {
    return DynamicColor.fromPalette(
      name: "text_primary_inverse_disable_only",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 10.0 : 90.0,
    );
  }

  @override
  DynamicColor textSecondaryAndTertiaryInverseDisabled() {
    return DynamicColor.fromPalette(
      name: "text_secondary_and_tertiary_inverse_disabled",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 10.0 : 90.0,
    );
  }

  @override
  DynamicColor textHintInverse() {
    return DynamicColor.fromPalette(
      name: "text_hint_inverse",
      palette: (s) => s.neutralPalette,
      tone: (s) => s.isDark ? 10.0 : 90.0,
    );
  }

  @override
  DynamicColor highestSurface(DynamicScheme s) {
    return s.isDark ? surfaceBright() : surfaceDim();
  }

  @override
  Hct getHct(DynamicScheme scheme, DynamicColor color) {
    final tone = getTone(scheme, color);
    return color.palette(scheme).getHct(tone);
  }

  @override
  double getTone(DynamicScheme scheme, DynamicColor color) {
    final decreasingContrast = scheme.contrastLevel < 0;
    final toneDeltaPair = color.toneDeltaPair?.call(scheme);

    // Case 1: dual foreground, pair of colors with delta constraint.
    if (toneDeltaPair != null) {
      final roleA = toneDeltaPair.roleA;
      final roleB = toneDeltaPair.roleB;
      final delta = toneDeltaPair.delta;
      final polarity = toneDeltaPair.polarity;
      final stayTogether = toneDeltaPair.stayTogether;

      final aIsNearer =
          (toneDeltaPair.constraint == DeltaConstraint.nearer ||
          (polarity == TonePolarity.lighter && !scheme.isDark) ||
          (polarity == TonePolarity.darker && !scheme.isDark));
      final nearer = aIsNearer ? roleA : roleB;
      final farther = aIsNearer ? roleB : roleA;
      final amNearer = color.name == nearer.name;
      final expansionDir = scheme.isDark ? 1 : -1;
      double nTone = nearer.tone(scheme);
      double fTone = farther.tone(scheme);

      // 1st round: solve to min, each
      if (color.background != null &&
          nearer.contrastCurve != null &&
          farther.contrastCurve != null) {
        final bg = color.background?.call(scheme);
        final nContrastCurve = nearer.contrastCurve?.call(scheme);
        final fContrastCurve = farther.contrastCurve?.call(scheme);
        if (bg != null && nContrastCurve != null && fContrastCurve != null) {
          final nContrast = nContrastCurve.get(scheme.contrastLevel);
          final fContrast = fContrastCurve.get(scheme.contrastLevel);
          final bgTone = bg.getTone(scheme);

          // If a color is good enough, it is not adjusted.
          // Initial and adjusted tones for `nearer`
          if (Contrast.ratioOfTones(bgTone, nTone) < nContrast) {
            nTone = DynamicColor.foregroundTone(bgTone, nContrast);
          }
          // Initial and adjusted tones for `farther`
          if (Contrast.ratioOfTones(bgTone, fTone) < fContrast) {
            fTone = DynamicColor.foregroundTone(bgTone, fContrast);
          }

          if (decreasingContrast) {
            // If decreasing contrast, adjust color to the "bare minimum"
            // that satisfies contrast.
            nTone = DynamicColor.foregroundTone(bgTone, nContrast);
            fTone = DynamicColor.foregroundTone(bgTone, fContrast);
          }
        }
      }

      // If constraint is not satisfied, try another round.
      if ((fTone - nTone) * expansionDir < delta) {
        // 2nd round: expand farther to match delta.
        fTone = MathUtils.clampDouble(0, 100, nTone + delta * expansionDir);
        // If constraint is not satisfied, try another round.
        if ((fTone - nTone) * expansionDir < delta) {
          // 3rd round: contract nearer to match delta.
          nTone = MathUtils.clampDouble(0, 100, fTone - delta * expansionDir);
        }
      }

      // Avoids the 50-59 awkward zone.
      if (50 <= nTone && nTone < 60) {
        // If `nearer` is in the awkward zone, move it away, together with
        // `farther`.
        if (expansionDir > 0) {
          nTone = 60;
          fTone = math.max(fTone, nTone + delta * expansionDir);
        } else {
          nTone = 49;
          fTone = math.min(fTone, nTone + delta * expansionDir);
        }
      } else if (50 <= fTone && fTone < 60) {
        if (stayTogether) {
          // Fixes both, to avoid two colors on opposite sides of the "awkward
          // zone".
          if (expansionDir > 0) {
            nTone = 60;
            fTone = math.max(fTone, nTone + delta * expansionDir);
          } else {
            nTone = 49;
            fTone = math.min(fTone, nTone + delta * expansionDir);
          }
        } else {
          // Not required to stay together; fixes just one.
          if (expansionDir > 0) {
            fTone = 60;
          } else {
            fTone = 49;
          }
        }
      }

      // Returns `nTone` if this color is `nearer`, otherwise `fTone`.
      return amNearer ? nTone : fTone;
    } else {
      // Case 2: No contrast pair; just solve for itself.
      double answer = color.tone(scheme);

      if (color.background?.call(scheme) == null ||
          color.contrastCurve?.call(scheme) == null) {
        return answer; // No adjustment for colors with no background.
      }

      final bgTone = color.background!(scheme)!.getTone(scheme);
      final desiredRatio = color.contrastCurve!(scheme)!.get(
        scheme.contrastLevel,
      );

      if (Contrast.ratioOfTones(bgTone, answer) >= desiredRatio) {
        // Don't "improve" what's good enough.
      } else {
        // Rough improvement.
        answer = DynamicColor.foregroundTone(bgTone, desiredRatio);
      }

      if (decreasingContrast) {
        answer = DynamicColor.foregroundTone(bgTone, desiredRatio);
      }

      if (color.isBackground && 50 <= answer && answer < 60) {
        // Must adjust
        if (Contrast.ratioOfTones(49, bgTone) >= desiredRatio) {
          answer = 49;
        } else {
          answer = 60;
        }
      }

      if (color.secondBackground?.call(scheme) == null) {
        return answer;
      }

      // Case 3: Adjust for dual backgrounds.
      final bgTone1 = color.background!(scheme)!.getTone(scheme);
      final bgTone2 = color.secondBackground!(scheme)!.getTone(scheme);

      final upper = math.max(bgTone1, bgTone2);
      final lower = math.min(bgTone1, bgTone2);

      if (Contrast.ratioOfTones(upper, answer) >= desiredRatio &&
          Contrast.ratioOfTones(lower, answer) >= desiredRatio) {
        return answer;
      }

      // The darkest light tone that satisfies the desired ratio,
      // or -1 if such ratio cannot be reached.
      final lightOption = Contrast.lighter(upper, desiredRatio);

      // The lightest dark tone that satisfies the desired ratio,
      // or -1 if such ratio cannot be reached.
      final darkOption = Contrast.darker(lower, desiredRatio);

      // Tones suitable for the foreground.
      final List<double> availables = [];
      if (lightOption != -1) {
        availables.add(lightOption);
      }
      if (darkOption != -1) {
        availables.add(darkOption);
      }

      bool prefersLight =
          DynamicColor.tonePrefersLightForeground(bgTone1) ||
          DynamicColor.tonePrefersLightForeground(bgTone2);
      if (prefersLight) {
        return (lightOption == -1) ? 100 : lightOption;
      }
      if (availables.length == 1) {
        return availables[0];
      }
      return (darkOption == -1) ? 0 : darkOption;
    }
  }

  @override
  TonalPalette getPrimaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => switch (variant) {
    Variant.content || Variant.fidelity => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      sourceColorHct.chroma,
    ),
    Variant.fruitSalad => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue - 50.0),
      48.0,
    ),
    Variant.monochrome => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      0.0,
    ),
    Variant.neutral => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 12.0),
    Variant.rainbow => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 48.0),
    Variant.tonalSpot => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      36.0,
    ),
    Variant.expressive => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 240),
      40,
    ),
    Variant.vibrant => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 200.0),
  };

  @override
  TonalPalette getSecondaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => switch (variant) {
    Variant.content || Variant.fidelity => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      math.max(sourceColorHct.chroma - 32.0, sourceColorHct.chroma * 0.5),
    ),
    Variant.fruitSalad => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue - 50.0),
      36.0,
    ),
    Variant.monochrome => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      0.0,
    ),
    Variant.neutral => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 8.0),
    Variant.rainbow => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 16.0),
    Variant.tonalSpot => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      16.0,
    ),
    Variant.expressive => TonalPalette.fromHueAndChroma(
      DynamicScheme.getRotatedHue(
        sourceColorHct,
        [0, 21, 51, 121, 151, 191, 271, 321, 360],
        [45, 95, 45, 20, 45, 90, 45, 45, 45],
      ),
      24.0,
    ),
    Variant.vibrant => TonalPalette.fromHueAndChroma(
      DynamicScheme.getRotatedHue(
        sourceColorHct,
        const [0, 41, 61, 101, 131, 181, 251, 301, 360],
        const [18, 15, 10, 12, 15, 18, 15, 12, 12],
      ),
      24.0,
    ),
  };

  @override
  TonalPalette getTertiaryPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => switch (variant) {
    Variant.content => TonalPalette.fromHct(
      DislikeAnalyzer.fixIfDisliked(
        TemperatureCache(sourceColorHct).getAnalogousColors(3, 6)[2],
      ),
    ),
    Variant.fidelity => TonalPalette.fromHct(
      DislikeAnalyzer.fixIfDisliked(
        TemperatureCache(sourceColorHct).getComplement(),
      ),
    ),
    Variant.fruitSalad => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      36.0,
    ),
    Variant.monochrome => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      0.0,
    ),
    Variant.neutral => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 16.0),
    Variant.rainbow || Variant.tonalSpot => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 60.0),
      24.0,
    ),
    Variant.expressive => TonalPalette.fromHueAndChroma(
      DynamicScheme.getRotatedHue(
        sourceColorHct,
        [0, 21, 51, 121, 151, 191, 271, 321, 360],
        [120, 120, 20, 45, 20, 15, 20, 120, 120],
      ),
      32.0,
    ),
    Variant.vibrant => TonalPalette.fromHueAndChroma(
      DynamicScheme.getRotatedHue(
        sourceColorHct,
        [0, 41, 61, 101, 131, 181, 251, 301, 360],
        [35, 30, 20, 25, 30, 35, 30, 25, 25],
      ),
      32.0,
    ),
  };

  @override
  TonalPalette getNeutralPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => switch (variant) {
    Variant.content || Variant.fidelity => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      sourceColorHct.chroma / 8.0,
    ),
    Variant.fruitSalad => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      10.0,
    ),
    Variant.monochrome => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      0.0,
    ),
    Variant.neutral => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 2.0),
    Variant.rainbow => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 0.0),
    Variant.tonalSpot => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 6.0),
    Variant.expressive => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 15),
      8,
    ),
    Variant.vibrant => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 10),
  };

  @override
  TonalPalette getNeutralVariantPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => switch (variant) {
    Variant.content || Variant.fidelity => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      (sourceColorHct.chroma / 8.0) + 4.0,
    ),
    Variant.fruitSalad => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      16.0,
    ),
    Variant.monochrome => TonalPalette.fromHueAndChroma(
      sourceColorHct.hue,
      0.0,
    ),
    Variant.neutral => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 2.0),
    Variant.rainbow => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 0.0),
    Variant.tonalSpot => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 8.0),
    Variant.expressive => TonalPalette.fromHueAndChroma(
      MathUtils.sanitizeDegreesDouble(sourceColorHct.hue + 15),
      12,
    ),
    Variant.vibrant => TonalPalette.fromHueAndChroma(sourceColorHct.hue, 12),
  };

  @override
  TonalPalette? getErrorPalette(
    Variant variant,
    Hct sourceColorHct,
    bool isDark,
    Platform platform,
    double contrastLevel,
  ) => null;
}
