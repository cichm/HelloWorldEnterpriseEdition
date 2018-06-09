import 'package:test/test.dart';

import '../body/algotithms/generate_random_inscription.dart';


void main() {
  test("should generate random inscription, and return non empty List", () {
    final String correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";
    final int creatureLength = 5;
    List<String> randomInscription = (new GenerateRandomInscription(creatureLength, correctCharacters)).build();

    expect(creatureLength, randomInscription.length);
  });
}