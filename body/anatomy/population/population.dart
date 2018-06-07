import 'dart:collection';
import 'dart:math' as math;

import '../../algotithms/generate_random_inscription.dart';
import '../../initialize_project.dart';
import '../../logger/logger.dart';
import '../FinitStateMachine/finit_state_machine.dart';
import '../FinitStateMachine/state.dart';
import '../Observer/observer.dart';
import '../creature/creature.dart';
import '../creature/creature_builder_.dart';
import '../creature/creature_details.dart';
import 'population_details.dart';

class Population extends State {
  static math.Random _random;
  static Logger _logger;
  static CreatureDetails _creatureDetails;
  static PopulationDetails _populationDetails;
  static List<Observer> list;
  Creature _creature;
  List<Creature> _creatureList;

  Population();

  Population._internal(
      int initialPopulation, Logger logger, PopulationDetails populationDetails)
      : assert(initialPopulation != 0) {
    logger.log("Default constructor start.");

    list = new List();
    list.add(new InitializeProject());

    _populationDetails = populationDetails;
    _random = new math.Random();
    _logger = logger;
    _initializePopulation(initialPopulation, _populationDetails.correctCharacters);
    logger.log("Default constructor end.");
  }

  void notifyObservers() => list.forEach((element) => element.notify());

  static createPopulation(int initialPopulation, Logger logger, PopulationDetails populationDetails) {
    return new Population._internal(initialPopulation, logger, populationDetails);
  }

  void _initializePopulation(int initialPopulation, String correctCharacters) {
    _logger.log("Initializa population function.");
    List<String> _primitiveInscription;

    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _logger.log("Get all creatures, and randomize characters.");

      _primitiveInscription = creatureToList(_primitiveInscription, correctCharacters);

      FinitStateMachine finitStateMachine = new FinitStateMachine();
      for(final int msg in [0, 1]){
        if (msg == 0) {
          finitStateMachine.buildInscription(_primitiveInscription);
        }
        else if (msg == 1) {
          finitStateMachine.clearData();
        }
      }

      // BUILDER
      _creature = new CreatureBuilder().withCreature(_creatureDetails).withLogger(_logger).build();
      _creature.live();

      int creatureFitness = _creature.creatureDetails.creatureFitness;
      if (!_populationDetails.population.containsKey(creatureFitness)) {
        _creatureList = new List();
      }
      else {
        _creatureList = new List.from(_populationDetails.population[creatureFitness]);
      }
      _creatureList.add(_creature);
      _populationDetails.population[creatureFitness] = _creatureList;
    }
  }


  List<String> creatureToList(List<String> _primitiveInscription, String correctCharacters) {
    _primitiveInscription = (
        new GenerateRandomInscription(_populationDetails.fitness, correctCharacters)
    ).build();
    return _primitiveInscription;
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
      for (int counter = 0; counter + 1 < _listKeys.length; counter = counter + 2) {
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

  bool calculatePopulationCondition() {
    if (_populationDetails.population[0] == null) {
      return false;
    }

    notifyObservers();

    return true;
  }

  void _removeWeak(int currentPopulationSize) {
    _logger.log("Remove old -  method.");
    if (_populationDetails.population.length > 3) {
      for (int counter = _populationDetails.population.lastKey(); (counter >= _populationDetails.population.firstKey() + 2 && _populationDetails.population.firstKey() + 2 > 3); counter--) {
        _populationDetails.population.remove(_populationDetails.population.lastKey());
      }
    }
  }

  @override
  void buildInscription(List<String> _primitiveInscription) {
    _creatureDetails = new CreatureDetails(
      _populationDetails.finalInscription, _populationDetails.correctCharacters,
      _populationDetails.fitness, _primitiveInscription,
    );
  }

  @override
  void clearData() {
    _creature = null;
    _creatureList = null;
  }
}
