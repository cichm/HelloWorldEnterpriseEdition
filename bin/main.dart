import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'package:random_string/random_string.dart' as randomString;
import 'dart:math' as math;
import 'dart:collection';
/**
 *
 */
main(List<String> arguments) {
  final String _finalInscription = "Hello World!";
  final int _fitness = _finalInscription.length;
  Population population = new Population(_finalInscription, _fitness, 400);
  while (!population.calculatePopulationCondition()) {
    population = new Population.mutation();
  }
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
/**
 *
 */
class Population {
  static String _finalInscription;
  static int _fitness;
  static SplayTreeMap<double, List<Creature>> _population;
  static math.Random _random;

  Population(String finalInscription, int fitness, int initialPopulation)
      :assert(finalInscription != ""), assert(fitness != 0),
        assert(initialPopulation != 0) {
    _finalInscription = finalInscription;
    _fitness = fitness;
    _random = new math.Random();
    _population = new SplayTreeMap<double, List<Creature>>();
    initiatingPopulation(initialPopulation);
  }
  Population.mutation() {
    List<Creature> _listKeys = new List();
    SplayTreeMap<double, List<Creature>> _childPopulation = new SplayTreeMap();

    for (double key in _population.keys) {
      _listKeys = new List.from(_population[key]);
      _childPopulation = new SplayTreeMap();
      for (int counter = 0; counter + 1 < _listKeys.length; counter = counter + 2) {
        int childsNumber = _random.nextInt(7);
        for (int count = 0; count < childsNumber; count++) {
          Creature creature = _listKeys[counter] + _listKeys[counter + 1];
          creature.live();
          if (!_childPopulation.containsKey(creature._creatureFitness)) {
            List<Creature> creatureList = new List();
            creatureList.add(creature);
            _childPopulation[creature._creatureFitness] = creatureList;
          }
          else {
            List<Creature> creatureList = new List.from(_childPopulation[creature._creatureFitness]);
            creatureList.add(creature);
            _childPopulation[creature._creatureFitness] = creatureList;
          }
        }
      }

      int currentPopulationSize = _population.length;
      removeOld(currentPopulationSize);

      _population = new SplayTreeMap.from(_childPopulation);
    }
  }
  bool calculatePopulationCondition() =>
      _population[1.0] != null &&
          _population[1.0].length * 100 / _population.length >= 10
          ? true : false;
  void removeOld(int currentPopulationSize) {
    if (currentPopulationSize >= 50) {
      for (int counter = 0; counter < currentPopulationSize / 2; counter++) {
        _population.remove(_population.lastKey());
      }
    }
  }
  void initiatingPopulation(int initialPopulation) {
    List<String> _primitiveInscription;
    Creature _creature;
    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _primitiveInscription = (new GenerateRandomInscription(_fitness)).build();
      _creature = new Creature(_finalInscription, _primitiveInscription, _fitness);
      _creature.live();
      if (!_population.containsKey(_creature._creatureFitness)) {
        List<Creature> creatureList = new List();
        creatureList.add(_creature);
        _population[_creature._creatureFitness] = creatureList;
      }
      else {
        List<Creature> creatureList = new List.from(_population[_creature._creatureFitness]);
        creatureList.add(_creature);
        _population[_creature._creatureFitness] = creatureList;
      }
    }
  }
}
/**
 *
 */
class Creature {
  final String _finalInscription;
  final int _fitness;
  static math.Random _random;
  List<String> _primitiveInscription;
  double _creatureFitness;
  Creature(this._finalInscription, this._primitiveInscription,
      this._fitness) : assert(_finalInscription != ""), assert(_fitness != 0),
        assert(_finalInscription.length != 0) {
    _random = new math.Random();
  }
  String get finalInscription => _finalInscription;
  List<String> get primitiveInscription => _primitiveInscription;
  double get creatureFitness => _creatureFitness;
  void _combineGenes(int _pivot, Creature secondParent) {
    List<String> parentFirstGenes = _primitiveInscription.take(_pivot)
        .toList();
    List<String> parentSecondCombines =
    secondParent._primitiveInscription.getRange(_pivot, _fitness).toList();
    _primitiveInscription = _genMutation(
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
    _combineGenes(_pivot, other);
    return this;
  }
  void live() {
    int _fit = 0;
    for (int counter = 0; counter < _fitness; counter++) {
      if (_primitiveInscription[counter] == _finalInscription[counter]) {
        _fit = _fit + 1;
      }
    }
    _creatureFitness = (_fit / _fitness);
  }
}
