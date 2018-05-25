import 'package:EA_DART/EA_DART.dart' as EA_DART;
import 'body/population/population.dart';
import 'logger/logger.dart';

main(List<String> arguments) {
  final Logger logger = new Logger("Main");
  logger.log("Main method started.");
  final String _finalInscription = "bacbacbac";
  final int _fitness = _finalInscription.length;
  final String _correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ"
      + "aąbcćdeęfghijklłmnńoópqrsśtuvwxyzźż"
      + " ";

  Population _population = new Population(
      _finalInscription, _correctCharacters, _fitness, 400, logger
  );

  while (!_population.calculatePopulationCondition()) {
    logger.log("New population.");
    _population = new Population.mutation();
  }
}
