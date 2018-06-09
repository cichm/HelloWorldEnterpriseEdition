import 'dart:collection';

import 'package:test/test.dart';

import '../body/anatomy/population/population.dart';
import '../body/anatomy/population/population_details.dart';
import '../body/logger/logger.dart';

void main() {
  test("should get right creature", () {
    final Logger logger = new Logger("Main");
    logger.log("Main method started.");
    final String _finalInscription = "AAAA";
    final int fitness = _finalInscription.length;
    final String correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";

    PopulationDetails _populationDetails = new PopulationDetails(_finalInscription, correctCharacters, fitness, new SplayTreeMap());
    // STATIC FACTORY METHOD
    Population population = Population.createPopulation(400, logger, _populationDetails);

    while (!population.calculatePopulationCondition()) {
      logger.log("New population.");
      population = new Population.mutation();
    }

    expect(_finalInscription, population.population[0][0].creatureDetails.finalInscription);
  });
}