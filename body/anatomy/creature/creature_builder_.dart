import '../../logger/logger.dart';
import 'creature.dart';
import 'creature_details.dart';

class CreatureBuilder {
  CreatureDetails _creatureDetails;
  Logger _logger;

  CreatureBuilder withCreature(CreatureDetails creatureDetails) {
    this._creatureDetails = creatureDetails;
    return this;
  }

  CreatureBuilder withLogger(Logger logger) {
    this._logger = logger;
    return this;
  }

  CreatureDetails get creatureDetails => _creatureDetails;

  Logger get logger => _logger;

  Creature build() {
    return new Creature(this);
  }
}