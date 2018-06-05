import 'dart:collection';
import '../creature/creature.dart';

class PopulationDetails {
  final String _finalInscription;
  final String _correctCharacters;
  final int _fitness;
  SplayTreeMap<int, List<Creature>> _population;

  PopulationDetails(this._finalInscription, this._correctCharacters,
      this._fitness, this._population):
        assert(_finalInscription != ""),
        assert(_correctCharacters != ""),
        assert(_fitness != 0);

  String get finalInscription => _finalInscription;

  String get correctCharacters => _correctCharacters;

  int get fitness => _fitness;

  SplayTreeMap<int, List<Creature>> get population => _population;


//  set primitiveInscription(List<String> value) {
//    _primitiveInscription = value;
//  }
//
//  set creatureFitness(int value) {
//    _creatureFitness = value;
//  }
//
//  String get finalInscription => _finalInscription;
//
//  String get correctCharacters => _correctCharacters;
//
//  int get fitness => _fitness;
//
//  List<String> get primitiveInscription => _primitiveInscription;
//
//  int get creatureFitness => _creatureFitness;
}