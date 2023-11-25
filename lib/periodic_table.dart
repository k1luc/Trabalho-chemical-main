import 'element.dart';
import 'dart:convert';
import 'dart:io';

class PeriodicTable {
  static final Map<String, Element> _elements = {};

  // Utilize um getter para acessar a propriedade elements
  static Map<String, Element> get elements {
    if (_elements.isEmpty) {
      loadElements(); // Chama o método de carregamento apenas se necessário
    }
    return _elements;
  }

  // Método privado para carregar os elementos
  static void loadElements() {
    final jsonString = File('elements.json').readAsStringSync();
    final List<Map<String, dynamic>> elementsData =
        (jsonDecode(jsonString) as List).cast<Map<String, dynamic>>();

    for (var elementData in elementsData) {
      var element = Element(
        elementData['symbol'],
        elementData['name'],
        elementData['latinName'],
        int.parse(elementData['weight']),
      );

      _elements[element.symbol] = element;
    }
  }
}


