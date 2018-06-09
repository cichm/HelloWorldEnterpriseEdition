import 'package:EA_DART/EA_DART.dart';
import 'package:test/test.dart';

import '../body/anatomy/creature/creature.dart';
import '../body/anatomy/creature/creature_builder_.dart';
import '../body/anatomy/creature/creature_details.dart';
import '../body/logger/logger.dart';

void main() {
  test("should create new child", () {
    final String correctCharacters = "AĄBCĆDEĘFGHIJKLŁMNŃOÓPQRSŚTUVWXYZŹŻ" + " ";
    List<String> primitiveInscription = ["K", "K", "K", "K"];
    List<String> primitiveInscriptionSecond = ["P", "P", "P", "P"];
    Logger logger = new Logger("LOGER");
    CreatureDetails creatureDetails = new CreatureDetails(
      "AAAA", correctCharacters, primitiveInscription.length, primitiveInscription,
    );
    CreatureDetails creatureDetailsSecond = new CreatureDetails(
      "AAAA", correctCharacters, primitiveInscription.length, primitiveInscriptionSecond,
    );
    Creature creature = new CreatureBuilder().withCreature(creatureDetails).withLogger(logger).build();
    creature.live();
    Creature creatureSecond = new CreatureBuilder().withCreature(creatureDetailsSecond).withLogger(logger).build();
    creature.live();
    Creature child = creature + creatureSecond;
    expect(primitiveInscription.length, child.creatureDetails.finalInscription.length);
  });
}