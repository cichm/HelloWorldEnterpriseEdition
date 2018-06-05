import 'dart:math' as math;

class GenerateRandomInscription {
  int _fitness;
  int _correntCharactersLenght;
  String _correctCharacters;
  math.Random _random;

  GenerateRandomInscription(this._fitness, this._correctCharacters)
      : assert(_fitness != 0) {
    _correntCharactersLenght = _correctCharacters.length;
    _random = new math.Random();
  }

  List<String> build() {
    return new List.generate(_fitness, (_) => _correctCharacters[_random.nextInt(_correntCharactersLenght)]);
  }
}