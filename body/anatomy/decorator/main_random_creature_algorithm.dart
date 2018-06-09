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

  List<String> randomCharacter() {
    List creatureCharacterItem = new List();
    String character;
    if(_randomMutalValue <= 60) {
      character = _creatureDetails.primitiveInscription[_counter];
    }
    else {
      character = _secondParent.creatureDetails.primitiveInscription[_counter];
    }

    creatureCharacterItem.add([character, _randomMutalValue, _creatureDetails.correctCharacters, _nextRandom]);
    return creatureCharacterItem;
  }
}