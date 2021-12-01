import '../shared/file-reader.dart';

void main() {
  var input = FileReader.read('problem1-input.txt');
  problem1Solution(input);
  problem2Solution(input);
}

void problem1Solution(Future<List<String>> input) async {
  var sanitizedInput = await input
      .asStream()
      .map((input) => input.map((datum) => int.parse(datum)).toList())
      .first;

  int depthIncreases = 0;
  int? previousElement = null;
  sanitizedInput.forEach((element) {
    if (previousElement != null && previousElement! < element) {
      depthIncreases++;
    }
    previousElement = element;
  });

  print('the Depth Increases $depthIncreases times');
}

void problem2Solution(Future<List<String>> input) async {
  var sanitizedInput = await input
      .asStream()
      .map((input) => input.map((datum) => int.parse(datum)).toList())
      .first;

  int depthIncreases = 0;
  int? previousSum = null;
  for (var i = 1; i <= sanitizedInput.length; i++) {
    int? currentSum;
    try {
      currentSum = sanitizedInput
          .sublist(i, i + 3)
          .reduce((value, element) => value + element);
    } catch (e) {
      currentSum = null;
    }

    if (previousSum != null &&
        i + 3 <= sanitizedInput.length &&
        previousSum < currentSum!) {
      depthIncreases++;
    }

    previousSum = currentSum;
  }
  print('the Depth Increases $depthIncreases times');
}
