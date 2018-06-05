import 'dart:math' as math;

class LevenshteinDistance {
  String _finalInscription;
  List<String> _primitiveInscription;

  LevenshteinDistance(this._finalInscription, this._primitiveInscription);

  int build() {
    var distance = new List.generate(
        _finalInscription.length + 1, (_) => new List(_primitiveInscription.length + 1)
    );

    for (int i = 0; i <= _finalInscription.length; i++)
      distance[i][0] = i;
    for (int j = 1; j <= _primitiveInscription.length; j++)
      distance[0][j] = j;

    for (int i = 1; i <= _finalInscription.length; i++) {
      for (int j = 1; j <= _primitiveInscription.length; j++) {
        List<int> k = [
          distance[i - 1][j] + 1,
          distance[i][j - 1] + 1,
          distance[i - 1][j - 1] + ((_finalInscription[i - 1] == _primitiveInscription[j - 1]) ? 0 : 1)
        ];

        distance[i][j] = k.reduce(math.min);
      }
    }

    return distance[_finalInscription.length][_primitiveInscription.length];
  }
}