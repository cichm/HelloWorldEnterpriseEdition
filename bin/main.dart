import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'dart:math' as math;
import 'dart:collection';
/**
 *
 */
main(List<String> arguments) {
  Logger logger = new Logger("Main");
  logger.log("Main method started.");
  final String _finalInscription = "Hello World";
  final int _fitness = _finalInscription.length;
  final String _correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ"
      + "aąbcćdeęfghijklłmnńoópqrsśtuvwxyzźż";
  Population _population = new Population(_finalInscription, _correctCharacters, _fitness, 400, logger);
  while (!_population.calculatePopulationCondition()) {
    logger.log("New population.");
    _population = new Population.mutation();
  }
}
/**
 *
 */
class GenerateRandomInscription {
  int _fitness;
  int _correntCharactersLenght;
  String _correctCharacters;
  math.Random _random;
  GenerateRandomInscription(this._fitness, this._correctCharacters)
      : assert(_fitness != 0) {
    _correntCharactersLenght = _correctCharacters.length;
    _random = new math.Random();
  }
  List<String> build() {
    return new List.generate(_fitness, (_) => _correctCharacters[_random.nextInt(_correntCharactersLenght)]);
  }
}
/**
 *
 */
class Population {
  static String _finalInscription;
  static String _correctCharacters;
  static int _fitness;
  static SplayTreeMap<int, List<Creature>> _population;
  static math.Random _random;
  static Logger _logger;

  Population(String finalInscription, String correctCharacters, int fitness, int initialPopulation, Logger logger)
      :assert(finalInscription != ""), assert(correctCharacters != ""),
        assert(fitness != 0), assert(initialPopulation != 0) {
    logger.log("Default constructor start.");
    _finalInscription = finalInscription;
    _correctCharacters = correctCharacters;
    _fitness = fitness;
    _random = new math.Random();

    _logger = logger;

    _population = new SplayTreeMap<int, List<Creature>>();
    _initiatingPopulation(initialPopulation, correctCharacters);
    logger.log("Default constructor end.");
  }
  Population.mutation() {
    _logger.log("Constructor [mutation] start.");
    List<Creature> _listKeys = new List();
    SplayTreeMap<int, List<Creature>> _childPopulation = new SplayTreeMap();

    for (int key in _population.keys) {
      _listKeys = new List.from(_population[key]);
      // TODO: Czasem problem z ewolucją, _listKeys.lenght == 1
      _logger.log("Key for-loop start: ${key}, ${_population[key][0]._primitiveInscription}, ${_listKeys.length}");
      for (int counter = 0; counter + 1 < _listKeys.length; counter = counter + 2) {
        _logger.log("Randomization parent pairs for-loop.");
        int childsNumber = _random.nextInt(7);
        for (int count = 0; count < childsNumber; count++) {
          _logger.log("Randomization number childs for-loop.");
          Creature creature = _listKeys[counter] + _listKeys[counter + 1];
          creature.live();

          List<Creature> creatureList;
          if (!_childPopulation.containsKey(creature._creatureFitness)) {
            creatureList = new List();
          }
          else {
            creatureList = new List.from(_childPopulation[creature._creatureFitness]);
          }
          creatureList.add(creature);
          _childPopulation[creature._creatureFitness] = creatureList;
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
    if (_population.length > 3) {
      for (int counter = _population.lastKey(); counter >=
          _population.firstKey() + 2; counter--) {
        _population.remove(_population.lastKey());
      }
    }
  }
  void _initiatingPopulation(int initialPopulation, String correctCharacters) {
    _logger.log("Initializa population function.");
    List<String> _primitiveInscription;
    Creature _creature;
    for (int counter = 0; counter < initialPopulation - 1; counter++) {
      _logger.log("Get all creatures, and randomize characters.");
      _primitiveInscription = (
          new GenerateRandomInscription(_fitness, correctCharacters)
      ).build();
      _creature = new Creature(
          _finalInscription, _correctCharacters, _primitiveInscription,
          _fitness, _logger
      );
      _creature.live();

      List<Creature> creatureList;
      if (!_population.containsKey(_creature._creatureFitness)) {
        creatureList = new List();
      }
      else {
        creatureList = new List.from(_population[_creature._creatureFitness]);
      }
      creatureList.add(_creature);
      _population[_creature._creatureFitness] = creatureList;
    }
  }
}
/**
 *
 */
class Creature {
  final String _finalInscription;
  final String _correctCharacters;
  final int _fitness;
  static math.Random _random;
  final Logger _logger;
  List<String> _primitiveInscription;
  int _creatureFitness;
  Creature(this._finalInscription, this._correctCharacters, this._primitiveInscription,
      this._fitness, this._logger) : assert(_finalInscription != ""),
        assert(_fitness != 0), assert(_finalInscription.length != 0) {
    _random = new math.Random();
  }
  String get finalInscription => _finalInscription;
  List<String> get primitiveInscription => _primitiveInscription;
  int get creatureFitness => _creatureFitness;
  void _combineGenes(Creature secondParent) {
    _logger.log("Parents: ${_primitiveInscription}, "
        "${secondParent._primitiveInscription}");
    List<String> _child = genMutation(secondParent);
    _primitiveInscription = new List.from(_child);
    _logger.log("\tChild: ${_primitiveInscription}, fitness: ${_creatureFitness}");
  }

  List<String> genMutation(Creature secondParent) {
    List<String> _child = new List(_fitness);
    for (int counter = 0; counter < _fitness; counter++) {
      int randomMutalValue = _random.nextInt(100);
      if (randomMutalValue <= 1) {
        _child[counter] = _correctCharacters[_random.nextInt(_fitness)];
      }
      else if(randomMutalValue <= 60) {
        _child[counter] = _primitiveInscription[counter];
      }
      else {
        _child[counter] = secondParent._primitiveInscription[counter];
      }
    }
    return _child;
  }
  operator+(other) {
    _logger.log("Reproduce method");
    _combineGenes(other);
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
