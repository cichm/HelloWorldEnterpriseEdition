import 'decorator.dart';
import 'main_random_creature_algorithm.dart';

class RedBlueRandomCreature extends Decorator {
  RedBlueRandomCreature(MainRandomCreatureAlgorithm mainRandomCreatureAlgorithm)
      : super(mainRandomCreatureAlgorithm) {
    print("");
  }

  List randomCharacter() {
    List randomCreature = super.mainRandomCreatureAlgorithm.randomCharacter();

    if (randomCreature[0][1] <= 1) {
//      randomCreature[0][0] = randomCreature.correctCharacters["2"];
    }

    return randomCreature;
  }
}