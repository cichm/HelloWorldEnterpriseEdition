import '../../i_initialize_project.dart';
import '../../initialize_project.dart';

class Proxy implements IInitializeProject {
  InitializeProject _initializeProject = new InitializeProject();

  Proxy() : super() {
    this._initializeProject = new InitializeProject();
  }

  @override
  void initialize() {
    _initializeProject.initialize();
    print("");
    print("------------------------------------------------------");
    print("POPULATION DETAILS");
    print("");
    print("Fitness: ${_initializeProject.populationDetails.fitness}");
    print("FinalInscription: ${_initializeProject.populationDetails.population[0][0].creatureDetails.finalInscription}");
    print("CorrectCharacters: ${_initializeProject.populationDetails.population[0][0].creatureDetails.correctCharacters}");
    print("------------------------------------------------------");
  }
}