// import 'package:material_color_utilities/material_color_utilities.dart';
// import 'package:test/test.dart';

import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:test/test.dart';

const int _red = 0xffff0000;
const int _green = 0xff00ff00;
const int _blue = 0xff0000ff;

void main() {
  // group('A group of tests', () {
  //   final awesome = Awesome();

  //   setUp(() {
  //     // Additional setup goes here.
  //   });

  //   test('First Test', () {
  //     expect(awesome.isAwesome, isTrue);
  //   });
  // });
  group("quantize", () {
    const quantizer = QuantizerCelebi();
    test("QuantizerCelebi 1R", () {
      final answer = quantizer.quantize([_red], 128);
      expect(answer.colorToCount.length, 1);
      expect(answer.colorToCount[_red], 1);
    });

    test("QuantizerCelebi 1G", () {
      final answer = quantizer.quantize([_green], 128);
      expect(answer.colorToCount.length, 1);
      expect(answer.colorToCount[_green], 1);
    });

    test("QuantizerCelebi 1B", () {
      final answer = quantizer.quantize([_blue], 128);
      expect(answer.colorToCount.length, 1);
      expect(answer.colorToCount[_blue], 1);
    });

    test("QuantizerCelebi 5B", () {
      final answer = quantizer.quantize(List.filled(5, _blue), 128);
      expect(answer.colorToCount.length, 1);
      expect(answer.colorToCount[_blue], 5);
    });

    test("QuantizerCelebi 2R 3G", () {
      final answer = quantizer.quantize([
        _red,
        _red,
        _green,
        _green,
        _green,
      ], 128);
      expect(answer.colorToCount.length, 2);
      expect(answer.colorToCount[_red], 2);
      expect(answer.colorToCount[_green], 3);
    });

    test("QuantizerCelebi 1R 1G 1B", () {
      final answer = quantizer.quantize([_red, _green, _blue], 128);
      expect(answer.colorToCount.length, 3);
      expect(answer.colorToCount[_red], 1);
      expect(answer.colorToCount[_green], 1);
      expect(answer.colorToCount[_blue], 1);
    });
  });
}
