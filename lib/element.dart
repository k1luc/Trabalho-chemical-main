import 'dart:convert';
import 'dart:io';

class Element {
  final String symbol;
  final String name;
  final String latinName;
  final int weight;

  Element(this.symbol, this.name, this.latinName, this.weight) {
    List<String> validSymbols = symbolsFile();
    if (!validSymbols.contains(symbol)) {
      throw Exception();
    }
  }

  List<String> symbolsFile() {
    final jsonString = File('elements.json').readAsStringSync();
    final List<Map<String, dynamic>> elementsData =
        (jsonDecode(jsonString) as List).cast<Map<String, dynamic>>();

    return elementsData.map((element) => element['symbol'].toString()).toList();
  }
}

