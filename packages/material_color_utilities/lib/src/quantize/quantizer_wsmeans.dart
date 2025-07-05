import 'quantizer.dart';
import 'quantizer_result.dart';

final class QuantizerWsmeans implements Quantizer {
  const QuantizerWsmeans();

  @override
  QuantizerResult quantize(
    List<int> pixels,
    int maxColors, {
    List<int> startingClusters = const [],
  }) {
    // TODO: implement
    return QuantizerResult(colorToCount: {});
  }
}
