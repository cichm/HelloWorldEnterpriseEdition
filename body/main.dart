import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'dart:collection';
import 'anatomy/population/population.dart';
import 'anatomy/population/population_details.dart';
import 'logger/logger.dart';

main(List<String> arguments) {
  final Logger logger = new Logger("Main");
  logger.log("Main method started.");
  final String _finalInscription = "ĄCĆĆBA";
  final int _fitness = _finalInscription.length;
  final String _correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";

  Population _population = new Population(400, logger,
      new PopulationDetails(_finalInscription, _correctCharacters, _fitness, new SplayTreeMap())
  );

  while (!_population.calculatePopulationCondition()) {
    logger.log("New population.");
    _population = new Population.mutation();
  }
}
