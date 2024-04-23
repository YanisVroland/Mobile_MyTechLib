import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_tech_lib/views/auth/login_page_screen.dart';

void main() {
  testWidgets('Login page widget test', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: LoginPageWidget()));

    expect(find.text(''), findsNWidgets(2));

    await tester.enterText(find.byKey(const Key('emailTextField')), 'yanis.vroland@gmail.com');
    await tester.pump();

    expect(find.text('yanis.vroland@gmail.com'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('passwordTextField')), 'Ascvbn.10');
    await tester.pump();

    expect(find.text('Ascvbn.10'), findsOneWidget);

    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();

  });
}
