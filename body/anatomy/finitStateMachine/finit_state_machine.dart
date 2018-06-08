import '../population/population.dart';
import 'state.dart';

class FinitStateMachine {
  List<State> _states = [new Population()];

  int _current = 0;

  void buildInscription(List<String> _primitiveInscription) {
    _states[_current].buildInscription(_primitiveInscription);
  }

  void clearData() {
    _states[_current].clearData();
  }
}