import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'package:random_string/random_string.dart' as randomString;
import 'dart:math' as math;
import 'dart:collection';
/**
 *
 */
main(List<String> arguments) {
  Logger logger = new Logger("Main");
  logger.log("Main method started.");
  final String _finalInscription = "Hello World!";
  final int _fitness = _finalInscription.length;
  Population _population = new Population(_finalInscription, _fitness, 400, logger);
  while (!_population.calculatePopulationCondition()) {
    logger.log("New population.");
    _population = new Population.mutation();
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
  static SplayTreeMap<int, List<Creature>> _population;
  static math.Random _random;
  static Logger _logger;

  Population(String finalInscription, int fitness, int initialPopulation, Logger logger)
      :assert(finalInscription != ""), assert(fitness != 0),
        assert(initialPopulation != 0) {
    logger.log("Default constructor start.");
    _finalInscription = finalInscription;
    _fitness = fitness;
    _random = new math.Random();

    _logger = logger;

    _population = new SplayTreeMap<int, List<Creature>>();
    _initiatingPopulation(initialPopulation);
    logger.log("Default constructor end.");
  }
  Population.mutation() {
    _logger.log("Constructor [mutation] start.");
    List<Creature> _listKeys = new List();
    SplayTreeMap<int, List<Creature>> _childPopulation = new SplayTreeMap();

    for (int key in _population.keys) {
      _logger.log("Key for-loop start");
      _listKeys = new List.from(_population[key]);
      for (int counter = 0; counter + 1 < _listKeys.length; counter = counter + 2) {
        _logger.log("Randomization parent pairs for-loop.");
        int childsNumber = _random.nextInt(7);
        for (int count = 0; count < childsNumber; count++) {
          _logger.log("Randomization number childs for-loop.");
          Creature creature = _listKeys[counter] + _listKeys[counter + 1];
          creature.live();

        // "Założyć, że warunek jest zawsze spełniony
          List<Creature> creatureList;
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
    }

    void iterateMapEntry(key, value) {
      if (_population[key] == null) _population[key] = new List();
      _population[key].addAll(value);
    }
    _childPopulation.forEach(iterateMapEntry);

    int currentPopulationSize = _population.length;
    _removeWeak(currentPopulationSize);
  }
  bool calculatePopulationCondition() =>
      _population[1.0] != null &&
          _population[1.0].length * 100 / _population.length >= 10
          ? true : false;
  void _removeWeak(int currentPopulationSize) {
    _logger.log("Remove old -  method.");
    _population.remove(_population.lastKey());
/*
    int minimum = (_population.length * 0.3).round();
    for (int counter = _population.length; counter > minimum; counter--) {
      _population.remove(_population.lastKey());
    }
*/
  }
  void _initiatingPopulation(int initialPopulation) {
    _logger.log("Initializa population function.");
    List<String> _primitiveInscription;
    Creature _creature;
    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _logger.log("Get all creatures, and randomize characters.");
      _primitiveInscription = (new GenerateRandomInscription(_fitness)).build();
      _creature = new Creature(_finalInscription, _primitiveInscription, _fitness, _logger);
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
  final Logger _logger;
  List<String> _primitiveInscription;
  int _creatureFitness;
  Creature(this._finalInscription, this._primitiveInscription,
      this._fitness, this._logger) : assert(_finalInscription != ""),
        assert(_fitness != 0), assert(_finalInscription.length != 0) {
    _random = new math.Random();
  }
  String get finalInscription => _finalInscription;
  List<String> get primitiveInscription => _primitiveInscription;
  int get creatureFitness => _creatureFitness;
  void _combineGenes(int _pivot, Creature secondParent) {
    _logger.log("Parents: ${_primitiveInscription}, "
        "${secondParent._primitiveInscription}");

    List<String> parentFirstGenes = _primitiveInscription.take(_pivot)
        .toList();
    List<String> parentSecondCombines =
    secondParent._primitiveInscription.getRange(_pivot, _fitness).toList();
    _primitiveInscription = _genMutation(
        new List.from(parentFirstGenes)..addAll(parentSecondCombines)
    );

    _logger.log("\tChild ${_primitiveInscription}");
  }
  List<String> _genMutation(List<String> gene) {
    _logger.log("Gen mutation method.");
    gene[_random.nextInt(_fitness)] = randomString.randomString(1);
    return gene;
  }
  operator+(other) {
    _logger.log("Reproduce method");
    int _pivot = _random.nextInt(_fitness);
    _combineGenes(_pivot, other);
    return this;
  }
  void live() {
    _logger.log("Live method.");

    _creatureFitness = _levenshteinDistance(
        _finalInscription,
        _primitiveInscription
    );
  }
  int _levenshteinDistance(String _finalInscription, List<String> _primitiveInscription) {
    var distance = new List.generate(
        _finalInscription.length + 1, (_) => new List(_primitiveInscription.length + 1)
    );

    for (int i = 0; i <= _finalInscription.length; i++)
      distance[i][0] = i;
    for (int j = 1; j <= _primitiveInscription.length; j++)
      distance[0][j] = j;

    for (int i = 1; i <= _finalInscription.length; i++) {
      for (int j = 1; j <= _primitiveInscription.length; j++) {
        List<int> k = [
          distance[i - 1][j] + 1,
          distance[i][j - 1] + 1,
          distance[i - 1][j - 1] + ((_finalInscription[i - 1] == _primitiveInscription[j - 1]) ? 0 : 1)
        ];

        distance[i][j] = k.reduce(math.min);
      }
    }

    return distance[_finalInscription.length][_primitiveInscription.length];
  }
}
/**
 *
 */
class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
