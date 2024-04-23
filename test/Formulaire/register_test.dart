import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_tech_lib/views/auth/register_account_screen.dart';

void main() {
  testWidgets('Register Account Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RegisterAccountWidget(),
    ));

    expect(find.text('Créez votre compte ci-dessous.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('lastNameTextField')), 'Doe');
    await tester.enterText(find.byKey(const Key('firstNameTextField')), 'John');
    await tester.enterText(find.byKey(const Key('emailTextField')), 'johndoe@example.com');
    await tester.enterText(find.byKey(const Key('passwordCreateTextField')), 'password123');
    await tester.enterText(find.byKey(const Key('passwordConfirmTextField')), 'password123');

    await tester.tap(find.text('Créer un compte'));
    await tester.pumpAndSettle();

    expect(find.text('Doe'), findsOneWidget);
    expect(find.text('John'), findsOneWidget);

    expect(find.text('johndoe@example.com'), findsOneWidget);

    expect(find.text('password123'), findsNWidgets(2));

    expect(find.text('Créer un compte'), findsOneWidget);

  });
}
