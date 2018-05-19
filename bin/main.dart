import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'package:random_string/random_string.dart' as randomString;
import 'dart:math' as math;

/**
 *
 */
main(List<String> arguments) {
  final String _finalInscription = "Hello World!";
  final int _fitness = _finalInscription.length;
  Population population = new Population(_finalInscription, _fitness);
  population.build();
}

/**
 *
 */
class GenerateRandomInscription {
  final int _fitness;

  GenerateRandomInscription(this._fitness) : assert(_fitness != 0);

  List<String> build() {
    return new List.generate(_fitness, (_) => randomString.randomString(1));
  }
}

class Population {
  final String _finalInscription;
  final int _fitness;
  Map<int, List<Creature>> _map;

  Population(this._finalInscription, this._fitness)
      : assert(_finalInscription != ""), assert(_fitness != 0) {
    _map = new Map();
  }

  void build() {
    // TODO:
    Map<int, List<String>> map = new Map();
    if (!map.containsKey(1)) {
      List<String> s = new List();
      map[1] = s;
    }

    for (int counter = 0; counter < 100; counter++) {

    }

    List<String> _primitiveInscription = (new GenerateRandomInscription(_fitness)).build();
    List<String> _primitiveInscription1 = (new GenerateRandomInscription(_fitness)).build();

    Creature evolutionPopulation = new Creature(
        "Hello World!", _primitiveInscription, _fitness
    );
    evolutionPopulation.live();

    Creature evolutionPopulation1 = new Creature(
        "Hello World!", _primitiveInscription1, _fitness
    );
    evolutionPopulation1.live();

    List<String> end = evolutionPopulation + evolutionPopulation1;
    print(end);
  }
}

/**
 *
 */
class Creature {
  final String _finalInscription;
  final int _fitness;
  math.Random _random;
  List<String> _primitiveInscription;

  Creature(this._finalInscription, this._primitiveInscription,
      this._fitness) : assert(_finalInscription != ""), assert(_fitness != 0),
        assert(_finalInscription.length != 0) {
    _random = new math.Random();
  }

  String get finalInscription => _finalInscription;

  List<String> get primitiveInscription => _primitiveInscription;

  List<String> _combineGenes(int _pivot, Creature secondParent) {
    List<String> parentFirstGenes = _primitiveInscription.take(_pivot)
        .toList();

    List<String> parentSecondCombines =
        secondParent._primitiveInscription.getRange(_pivot, _fitness).toList();

    return _genMutation(
        new List.from(parentFirstGenes)..addAll(parentSecondCombines)
    );
  }

  List<String> _genMutation(List<String> gene) {
    gene[_random.nextInt(_fitness)] = randomString.randomString(1);

    return gene;
  }

  /// Reproduce
  operator+(other) {
    int _pivot = _random.nextInt(_fitness);

    return _combineGenes(_pivot, other);
  }

  double live() {
    int _fit = 0;

    for (int counter = 0; counter < _fitness; counter++) {
      if (_primitiveInscription[counter] == _finalInscription[counter]) {
        _fit = _fit + 1;
      }
    }

    return (_fit / _fitness);
  }
}
