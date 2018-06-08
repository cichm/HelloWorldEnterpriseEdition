import '../creature/creature.dart';
import '../creature/creature_details.dart';
import 'i_random_ceature_algorithm.dart';

class MainRandomCreatureAlgorithm implements IRandomCreatureAlgorithm{
  int _randomMutalValue;
  CreatureDetails _creatureDetails;
  Creature _secondParent;
  int _counter;
  int _nextRandom;

  MainRandomCreatureAlgorithm(this._randomMutalValue, this._creatureDetails,
      this._secondParent, this._counter, this._nextRandom);

  String randomCharacter() {
    if (_randomMutalValue <= 1) {
      return _creatureDetails.correctCharacters[_nextRandom];
    }
    else if(_randomMutalValue <= 60) {
      return _creatureDetails.primitiveInscription[_counter];
    }
    else {
      return _secondParent.creatureDetails.primitiveInscription[_counter];
    }
  }
}