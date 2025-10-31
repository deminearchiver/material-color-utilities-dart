import 'package:test/test.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

void main() {
  group("dislike analyzer", () {
    test("likes Monk Skin Tone Scale colors", () {
      // From https://skintone.google#/get-started
      final monkSkinToneScaleColors = [
        0xfff6ede4,
        0xfff3e7db,
        0xfff7ead0,
        0xffeadaba,
        0xffd7bd96,
        0xffa07e56,
        0xff825c43,
        0xff604134,
        0xff3a312a,
        0xff292420,
      ];
      for (final color in monkSkinToneScaleColors) {
        expect(DislikeAnalyzer.isDisliked(Hct.fromInt(color)), isFalse);
      }
    });

    test("dislikes bile colors", () {
      const List<int> unlikable = [
        0xff95884B,
        0xff716B40,
        0xffB08E00,
        0xff4C4308,
        0xff464521,
      ];
      for (final color in unlikable) {
        expect(DislikeAnalyzer.isDisliked(Hct.fromInt(color)), isTrue);
      }
    });

    test("makes bile colors likable", () {
      const List<int> unlikable = [
        0xff95884B,
        0xff716B40,
        0xffB08E00,
        0xff4C4308,
        0xff464521,
      ];
      for (final color in unlikable) {
        final hct = Hct.fromInt(color);
        expect(DislikeAnalyzer.isDisliked(hct), isTrue);
        final likable = DislikeAnalyzer.fixIfDisliked(hct);
        expect(DislikeAnalyzer.isDisliked(likable), isFalse);
      }
    });

    test("likes tone 67 colors", () {
      final color = Hct.from(100.0, 50.0, 67.0);
      expect(DislikeAnalyzer.isDisliked(color), isFalse);
      expect(DislikeAnalyzer.fixIfDisliked(color).toInt(), color.toInt());
    });
  });
}
