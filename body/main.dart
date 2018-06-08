import 'package:EA_DART/EA_DART.dart' as EA_DART;

import 'anatomy/proxy/proxy.dart';
import 'i_initialize_project.dart';

main(List<String> arguments) {
  IInitializeProject initializeProject = new Proxy();
  initializeProject.initialize();
}