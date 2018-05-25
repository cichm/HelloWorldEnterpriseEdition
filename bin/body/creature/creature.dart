import 'dart:math' as math;

import '../../algotithms/levenshtein_distance.dart';
import '../../logger/logger.dart';

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

  String get finalInscription =>
      _finalInscription;

  List<String> get primitiveInscription =>
      _primitiveInscription;

  int get creatureFitness =>
      _creatureFitness;

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

    _creatureFitness = (
        new LevenshteinDistance(_finalInscription, _primitiveInscription)
    ).build();
  }
}