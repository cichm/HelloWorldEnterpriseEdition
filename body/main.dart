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

  // STATIC FACTORY METHOD
  Population _population = Population.createPopulation(400, logger, new PopulationDetails(_finalInscription, _correctCharacters, _fitness, new SplayTreeMap()));

  while (!_population.calculatePopulationCondition()) {
    logger.log("New population.");
    _population = new Population.mutation();
  }

//  final Pizza pizza = new PizzaBuilder().setCrust().setSauce().build();
//  print(pizza);
//  print("");
}

//class Pizza {
//  String _sauce;
//  String _crust;
//
//  Pizza(PizzaBuilder pizzaBuilder) {
//    this._sauce = pizzaBuilder.sauce;
//    this._crust = pizzaBuilder.crust;
//  }
//
//  String get crust => _crust;
//
//  String get sauce => _sauce;
//}
//
//class PizzaBuilder {
//  String sauce;
//  String crust;
//
//  PizzaBuilder setSauce() {
//    this.sauce = "1234";
//    return this;
//  }
//
//  PizzaBuilder setCrust() {
//    this.crust = "1234";
//    return this;
//  }
//
//  Pizza build() {
//    return new Pizza(this);
//  }
//}