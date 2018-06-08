import 'decorator.dart';
import 'main_random_creature_algorithm.dart';

class RedBlueRandomCreature extends Decorator {
  RedBlueRandomCreature(MainRandomCreatureAlgorithm mainRandomCreatureAlgorithm)
      : super(mainRandomCreatureAlgorithm);

  String randomCharacter() {
    return super.randomCharacter();
  }
}