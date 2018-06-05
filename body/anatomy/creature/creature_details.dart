class CreatureDetails {
  final String _finalInscription;
  final String _correctCharacters;
  final int _fitness;
  List<String> _primitiveInscription;
  int _creatureFitness;

  CreatureDetails(this._finalInscription, this._correctCharacters,
      this._fitness, this._primitiveInscription);

  set primitiveInscription(List<String> value) {
    _primitiveInscription = value;
  }

  set creatureFitness(int value) {
    _creatureFitness = value;
  }

  String get finalInscription => _finalInscription;

  String get correctCharacters => _correctCharacters;

  int get fitness => _fitness;

  List<String> get primitiveInscription => _primitiveInscription;

  int get creatureFitness => _creatureFitness;
}