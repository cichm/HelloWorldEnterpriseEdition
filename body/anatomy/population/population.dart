import 'dart:collection';
import 'dart:math' as math;

import '../../algotithms/generate_random_inscription.dart';
import '../../logger/logger.dart';
import '../creature/creature.dart';
import '../creature/creature_details.dart';
import 'population_details.dart';

class Population {
  PopulationDetails populationDetails;

  static math.Random _random;
  static Logger _logger;

  static CreatureDetails _creatureDetails;
  static PopulationDetails _populationDetails;

  Population(
      int initialPopulation, Logger logger, PopulationDetails populationDetails)
      :assert(initialPopulation != 0) {
    logger.log("Default constructor start.");
    _populationDetails = populationDetails;
    _random = new math.Random();
    _logger = logger;
    _initializePopulation(initialPopulation, _populationDetails.correctCharacters);
    logger.log("Default constructor end.");
  }

  void _initializePopulation(int initialPopulation, String correctCharacters) {
    _logger.log("Initializa population function.");
    List<String> _primitiveInscription;
    Creature creature;
    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _logger.log("Get all creatures, and randomize characters.");
      _primitiveInscription = (
          new GenerateRandomInscription(_populationDetails.fitness, correctCharacters)
      ).build();

      _creatureDetails = new CreatureDetails(
        _populationDetails.finalInscription, _populationDetails.correctCharacters,
        _populationDetails.fitness, _primitiveInscription,
      );

      creature = new Creature(_creatureDetails, _logger);

      creature.live();

      List<Creature> creatureList;
      int creatureFitness = creature.creatureDetails.creatureFitness;
      if (!_populationDetails.population.containsKey(creatureFitness)) {
        creatureList = new List();
      }
      else {
        creatureList = new List.from(_populationDetails.population[creatureFitness]);
      }
      creatureList.add(creature);
      _populationDetails.population[creatureFitness] = creatureList;
    }
  }

  Population.mutation() {
    _logger.log("Constructor [mutation] start.");
    List<Creature> _listKeys = new List();
    SplayTreeMap<int, List<Creature>> _childPopulation = new SplayTreeMap();
    for (int key in _populationDetails.population.keys) {
      _listKeys = new List.from(_populationDetails.population[key]);
      // TODO: Czasem problem z ewolucją, _listKeys.lenght == 1
      _logger.log(
          "Key for-loop start: ${key}, "
          "${_populationDetails.population[key][0].creatureDetails.primitiveInscription}, "
          "${_listKeys.length}"
      );
      for (int counter = 0; counter + 1 < _listKeys.length;
      counter = counter + 2) {
        _logger.log("Randomization parent pairs for-loop.");
        int childsNumber = _random.nextInt(7);
        for (int count = 0; count < childsNumber; count++) {
          _logger.log("Randomization number childs for-loop.");
          Creature creature = _listKeys[counter] + _listKeys[counter + 1];
          creature.live();

          List<Creature> creatureList;
          int creatureFitness = creature.creatureDetails.creatureFitness;
          if (!_childPopulation.containsKey(creatureFitness)) {
            creatureList = new List();
          }
          else {
            creatureList = new List.from(_childPopulation[creatureFitness]);
          }
          creatureList.add(creature);
          _childPopulation[creatureFitness] = creatureList;
        }
      }
    }

    void iterateMapEntry(key, value) {
      if (_populationDetails.population[key] == null) _populationDetails.population[key] = new List();
      _populationDetails.population[key].addAll(value);
    }
    _childPopulation.forEach(iterateMapEntry);

    int currentPopulationSize = _populationDetails.population.length;
    _removeWeak(currentPopulationSize);
  }

  bool calculatePopulationCondition() => _populationDetails.population[0] != null;

  void _removeWeak(int currentPopulationSize) {
    _logger.log("Remove old -  method.");
    if (_populationDetails.population.length > 3) {
      for (int counter = _populationDetails.population.lastKey(); (counter >= _populationDetails.population.firstKey() + 2 && _populationDetails.population.firstKey() + 2 > 3); counter--) {
        _populationDetails.population.remove(_populationDetails.population.lastKey());
      }
    }
  }
}
