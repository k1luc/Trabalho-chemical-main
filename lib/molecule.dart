import 'periodic_table.dart';

class Molecule implements Comparable<Molecule> {
  String formula;
  String name;
  List<String> symbols = [];
  List<int> weights = [];
  List<int> finalWeights = [];
  List<String> concatenatedSymbols = [];
  String newElement = '';
  Molecule({
    required this.formula,
    required this.name,
  }) {
    if (formula.isEmpty) {
      throw Exception();
    }
  }

  @override
  int compareTo(Molecule other) {
    return weight.compareTo(other.weight);
  }

  int get weight {
    concatenatedSymbols.clear();
    finalWeights.clear();
    symbols.clear();
    int totalWeight = 0;
    String currentSymbol = "";

    for (int i = 0; i < formula.length; i++) {
      String currentChar = formula[i];

      if (_isUpperCase(currentChar)) {
        if (currentSymbol.isNotEmpty) {
          int atomicWeight = _getAtomicWeight(currentSymbol);

          symbols.add(currentSymbol);
          weights.add(atomicWeight);

          currentSymbol = "";
        }

        currentSymbol = currentChar;
      } else if (_isLowerCase(currentChar)) {
        currentSymbol += currentChar;
      }
    }

    if (currentSymbol.isNotEmpty) {
      int atomicWeight = _getAtomicWeight(currentSymbol);
      symbols.add(currentSymbol);
      weights.add(atomicWeight);
    }

    for (int i = 0; i < symbols.length; i++) {
      if (isNumeric(symbols[i]) &&
          i + 1 < symbols.length &&
          isNumeric(symbols[i + 1])) {
        newElement += symbols[i];
      } else {
        newElement += symbols[i];
        concatenatedSymbols.add(newElement);
        newElement = '';
      }
    }

    for (int i = 0; i < concatenatedSymbols.length; i++) {
      String element = concatenatedSymbols[i];

      if (isNumeric(element)) {
        finalWeights.add(0);
      } else {
        int weightSymbol = _getAtomicWeight(element);
        finalWeights.add(weightSymbol);
      }
    }

    for (int i = 0; i < concatenatedSymbols.length; i++) {
      if (int.tryParse(concatenatedSymbols[i]) != null) {
        int numero = int.parse(concatenatedSymbols[i]);
        if (i > 0) {
          finalWeights[i - 1] *= numero;
        }
      }
    }

    totalWeight = finalWeights
        .reduce((valorAnterior, elements) => valorAnterior + elements);

    return totalWeight;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  bool _isUpperCase(String s) => s == s.toUpperCase();
  bool _isLowerCase(String s) => s == s.toLowerCase();

  int _getAtomicWeight(String symbol) {
    return PeriodicTable.elements[symbol]?.weight ?? 0;
  }
}
