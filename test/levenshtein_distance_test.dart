import 'package:EA_DART/EA_DART.dart';
import 'package:test/test.dart';

import '../bin/algotithms/levenshtein_distance.dart';

void main() {
  test("single inscription Levenshtein calculate", () {
    String _finalInscription = "Hello World!";
    List<String> _primitiveInscription = ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"];
    int result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();

    expect(result, 0);
  });

  test("multiple not equal inscriptions Levenshtein calculate", () {
    String _finalInscription = "Sunday";
    List<String> _primitiveInscription = ["S", "a", "t", "u", "r", "d", "a", "y"];
    int result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();

    expect(result, 3);
  });
  
  test("multiple different inscriptions Levenshtein calculate", () {
    String _finalInscription = "Hello World!";
    List<String> _primitiveInscription = ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"];
    int result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 0);

    _finalInscription = "Sunday";
    _primitiveInscription = ["S", "a", "t", "u", "r", "d", "a", "y"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 3);

    _primitiveInscription = ["S", "a", "t", "u", "r", "d", "a", "y"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 3);

    _primitiveInscription = ["S", "a", "t", "u", "r", "d", "a"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 4);

    _primitiveInscription = ["S", "a", "t", "u", "r", "d"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 5);

    _primitiveInscription = ["S", "a", "t", "u", "r"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 5);

    _primitiveInscription = ["S", "a", "t", "u"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 5);

    _primitiveInscription = ["S", "a", "t"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 4);

    _primitiveInscription = ["S", "a"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 4);

    _primitiveInscription = ["S"];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 5);

    _primitiveInscription = [];
    result = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
    expect(result, 6);
  });
}
