import 'periodic_table.dart';
import 'element.dart';


class Atom {
  final String symbol;
  final int subscript;

  Atom(this.symbol, {this.subscript = 1});

  int getAtomicNumber() {
    Map<String, Element> elements = PeriodicTable.elements;
    Element? element = elements[symbol];

    if (element != null) {
      return element.weight;
    } else {
      return -1;
    }
  }

  double getAtomicWeight() {
    Map<String, Element> elements = PeriodicTable.elements;
    Element? element = elements[symbol];

    if (element != null) {
      return element.weight.toDouble() * subscript;
    } else {
      return 0.0;
    }
  }

  @override
  String toString() {
    int atomicNumber = getAtomicNumber();
    return "Atom Symbol: $symbol, Atomic Number: $atomicNumber";
  }
}
