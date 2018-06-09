import 'dart:io';
import 'dart:collection';
import 'anatomy/Observer/observer.dart';
import 'anatomy/population/population.dart';
import 'anatomy/population/population_details.dart';
import 'logger/logger.dart';

class InitializeProject implements Observer {
  PopulationDetails _populationDetails;

  DateTime _startInstant;

  InitializeProject() {
    _startInstant = new DateTime.now();
  }

  PopulationDetails get populationDetails => _populationDetails;

  void initialize() {
    final Logger logger = new Logger("Main");
    logger.log("Main method started.");
    final String finalInscription = "AAAAA";
    final int fitness = finalInscription.length;
    final String correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";

    _populationDetails = new PopulationDetails(finalInscription, correctCharacters, fitness, new SplayTreeMap());
    // STATIC FACTORY METHOD
    Population population = Population.createPopulation(400, logger, _populationDetails);

    while (!population.calculatePopulationCondition()) {
      logger.log("New population.");
      population = new Population.mutation();
    }
  }

  @override
  void notify() {
    final String filename = 'report.txt';
    final DateTime endInstant = new DateTime.now();
    new File(filename).writeAsString('Start instant: ' + _startInstant.toString() + ', end instant: ' + endInstant.toString() + '.')
        .then((File file) {
      print("Save report in " + file.path);
    });
  }
}