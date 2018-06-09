import 'decorator.dart';
import 'main_random_creature_algorithm.dart';

class RedBlueRandomCreature extends Decorator {
  RedBlueRandomCreature(MainRandomCreatureAlgorithm mainRandomCreatureAlgorithm)
      : super(mainRandomCreatureAlgorithm);

  List randomCharacter() {
    List randomCreature = super.mainRandomCreatureAlgorithm.randomCharacter();

    final randomValue = randomCreature[0][1];
    if (randomValue <= 1) {
      randomCreature[0][0] = randomCreature[0][2][randomCreature[0][3]];
    }

    return randomCreature;
  }
}