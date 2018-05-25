import 'dart:collection';
import 'dart:math' as math;

import '../algotithms/generate_random_inscription.dart';
import '../logger/logger.dart';
import 'creature/creature.dart';

class Population {
  static String _finalInscription;
  static String _correctCharacters;
  static int _fitness;
  static SplayTreeMap<int, List<Creature>> _population;
  static math.Random _random;
  static Logger _logger;

  Population(String finalInscription, String correctCharacters, int fitness,
      int initialPopulation, Logger logger)
      :assert(finalInscription != ""),
        assert(correctCharacters != ""),
        assert(fitness != 0),
        assert(initialPopulation != 0) {
    logger.log("Default constructor start.");
    _finalInscription = finalInscription;
    _correctCharacters = correctCharacters;
    _fitness = fitness;
    _random = new math.Random();
    _logger = logger;
    _population = new SplayTreeMap<int, List<Creature>>();

    _initializePopulation(initialPopulation, correctCharacters);

    logger.log("Default constructor end.");
  }

  void _initializePopulation(int initialPopulation, String correctCharacters) {
    _logger.log("Initializa population function.");
    List<String> _primitiveInscription;
    Creature creature;
    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _logger.log("Get all creatures, and randomize characters.");
      _primitiveInscription = (
          new GenerateRandomInscription(_fitness, correctCharacters)
      ).build();
      creature = new Creature(
          _finalInscription, _correctCharacters, _primitiveInscription,
          _fitness, _logger
      );
      creature.live();

      List<Creature> creatureList;
      if (!_population.containsKey(creature.creatureFitness)) {
        creatureList = new List();
      }
      else {
        creatureList = new List.from(_population[creature.creatureFitness]);
      }
      creatureList.add(creature);
      _population[creature.creatureFitness] = creatureList;
    }
  }

  Population.mutation() {
    _logger.log("Constructor [mutation] start.");
    List<Creature> _listKeys = new List();
    SplayTreeMap<int, List<Creature>> _childPopulation = new SplayTreeMap();
    for (int key in _population.keys) {
      _listKeys = new List.from(_population[key]);
      // TODO: Czasem problem z ewolucją, _listKeys.lenght == 1
      _logger.log("Key for-loop start: ${key}, ${_population[key][0]
          .primitiveInscription}, ${_listKeys.length}");
      for (int counter = 0; counter + 1 < _listKeys.length;
      counter = counter + 2) {
        _logger.log("Randomization parent pairs for-loop.");
        int childsNumber = _random.nextInt(7);
        for (int count = 0; count < childsNumber; count++) {
          _logger.log("Randomization number childs for-loop.");
          Creature creature = _listKeys[counter] + _listKeys[counter + 1];
          creature.live();

          List<Creature> creatureList;
          if (!_childPopulation.containsKey(creature.creatureFitness)) {
            creatureList = new List();
          }
          else {
            creatureList = new List.from(_childPopulation[creature.creatureFitness]);
          }
          creatureList.add(creature);
          _childPopulation[creature.creatureFitness] = creatureList;
        }
      }
    }

    void iterateMapEntry(key, value) {
      if (_population[key] == null) _population[key] = new List();
      _population[key].addAll(value);
    }
    _childPopulation.forEach(iterateMapEntry);

    int currentPopulationSize = _population.length;
    _removeWeak(currentPopulationSize);
  }

  bool calculatePopulationCondition() => _population[0] != null;

  void _removeWeak(int currentPopulationSize) {
    _logger.log("Remove old -  method.");
    if (_population.length > 3) {
      for (int counter = _population.lastKey(); counter >=
          _population.firstKey() + 2; counter--) {
        _population.remove(_population.lastKey());
      }
    }
  }
}
