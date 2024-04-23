import 'package:flutter_test/flutter_test.dart';
import 'formulaire/create_library_test.dart' as create_library_test;
import 'formulaire/create_project_test.dart' as create_project_test;
import 'formulaire/login_test.dart' as login_test;
import 'formulaire/register_test.dart' as register_test;
import 'main_test.dart' as main_test;

void main() {
  group("Test init project", () {
    // main_test.main();
  });

  group("Test formulaire", () {
    login_test.main();
    register_test.main();
    create_library_test.main();
    create_project_test.main();
  });
}
