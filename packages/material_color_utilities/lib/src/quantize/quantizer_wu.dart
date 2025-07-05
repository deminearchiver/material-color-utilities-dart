import 'quantizer.dart';
import 'quantizer_result.dart';

final class QuantizerWu implements Quantizer {
  const QuantizerWu();

  @override
  QuantizerResult quantize(List<int> pixels, int maxColors) {
    // TODO: implement
    return QuantizerResult(colorToCount: {});
  }
}
