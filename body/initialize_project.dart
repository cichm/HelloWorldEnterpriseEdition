import 'dart:collection';
import 'anatomy/Observer/observer.dart';
import 'anatomy/population/population.dart';
import 'anatomy/population/population_details.dart';
import 'logger/logger.dart';

class InitializeProject implements Observer {
  PopulationDetails _populationDetails;

  PopulationDetails get populationDetails => _populationDetails;

  void initialize() {
    final Logger logger = new Logger("Main");
    logger.log("Main method started.");
    final String _finalInscription = "AAAAA";
    final int _fitness = _finalInscription.length;
    final String _correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";

    _populationDetails = new PopulationDetails(_finalInscription, _correctCharacters, _fitness, new SplayTreeMap());
    // STATIC FACTORY METHOD
    Population population = Population.createPopulation(400, logger, _populationDetails);

    while (!population.calculatePopulationCondition()) {
      logger.log("New population.");
      population = new Population.mutation();
    }
  }

  @override
  void notify() {
    print("THE END!");
  }
}