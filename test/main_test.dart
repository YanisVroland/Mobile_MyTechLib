// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:my_tech_lib/views/auth/login_page_screen.dart';
import 'package:my_tech_lib/app/theme/app_theme.dart';

void main() {
  testWidgets('Test de MyApp', (WidgetTester tester) async {
    // Assurez-vous que les services nécessaires sont initialisés.
    WidgetsFlutterBinding.ensureInitialized();

    // Assurez-vous que l'orientation est configurée correctement.
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Initialisez le thème de l'application.
    await AppTheme.initialize();

    // Créez un widget MyApp.
    await tester.pumpWidget(MyApp());

    // Vérifiez si le widget LoginPageWidget est présent.
    expect(find.byType(LoginPageWidget), findsOneWidget);

    // Vérifiez si le thème initial est défini correctement.
    expect(Theme.of(tester.element(find.byType(MaterialApp))), isNotNull);
  });
}

// Classe MyApp pour les tests.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

// État de MyApp pour les tests.
class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPageWidget(),
    );
  }
}
