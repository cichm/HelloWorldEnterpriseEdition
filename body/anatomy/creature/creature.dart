import 'dart:math' as math;

import '../../algotithms/levenshtein_distance.dart';
import '../../logger/logger.dart';
import 'creature_builder_.dart';
import 'creature_details.dart';

class Creature {
  static math.Random _random;

  CreatureDetails _creatureDetails;

  Logger _logger;

  Creature(CreatureBuilder creatureBuilder) {
    _random = new math.Random();

    this._creatureDetails = creatureBuilder.creatureDetails;
    this._logger = creatureBuilder.logger;
  }

  CreatureDetails get creatureDetails => _creatureDetails;

  void _combineGenes(Creature secondParent) {
    _logger.log("Parents: ${creatureDetails.primitiveInscription}, "
        "${secondParent.creatureDetails.primitiveInscription}");
    List<String> _child = genMutation(secondParent);
    creatureDetails.primitiveInscription = new List.from(_child);
    _logger.log("\tChild: ${_creatureDetails.primitiveInscription}, fitness: ${_creatureDetails.creatureFitness}");
  }

  List<String> genMutation(Creature secondParent) {
    int _fitness = _creatureDetails.fitness;
    List<String> _child = new List(_fitness);
    for (int counter = 0; counter < _fitness; counter++) {
      int randomMutalValue = _random.nextInt(100);
      if (randomMutalValue <= 1) {
        _child[counter] = _creatureDetails.correctCharacters[_random.nextInt(_fitness)];
      }
      else if(randomMutalValue <= 60) {
        _child[counter] = _creatureDetails.primitiveInscription[counter];
      }
      else {
        _child[counter] = creatureDetails.primitiveInscription[counter];
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

    creatureDetails.creatureFitness = (
        new LevenshteinDistance(creatureDetails.finalInscription, creatureDetails.primitiveInscription)
    ).build();
  }
}