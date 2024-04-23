import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_tech_lib/services/models/user_model.dart';
import 'package:my_tech_lib/views/library/create_library_screen.dart';
import 'package:my_tech_lib/views/library/widget/create_company_library_widget.dart';

void main() {
  testWidgets('Create Library Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CreateLibraryWidget(UserModel()),
    ));

    expect(find.text('Nouvelle Librairie'), findsOneWidget);

    expect(find.text('Personnel'), findsOneWidget);
    expect(find.text('Entreprise'), findsOneWidget);

    await tester.tap(find.text('Entreprise'));
    await tester.pump();

    expect(find.byType(CreateCompanyLibraryWidget), findsOneWidget);


  });
}
