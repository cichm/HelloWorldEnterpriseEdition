import 'i_random_ceature_algorithm.dart';
import 'main_random_creature_algorithm.dart';

abstract class Decorator implements IRandomCreatureAlgorithm {
  MainRandomCreatureAlgorithm mainRandomCreatureAlgorithm;

  Decorator(this.mainRandomCreatureAlgorithm);
}