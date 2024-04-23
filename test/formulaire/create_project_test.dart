import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_tech_lib/app/routes/router.dart';
import 'package:my_tech_lib/app/widgets/button_custom.dart';
import 'package:my_tech_lib/app/widgets/dropdown_custom.dart';
import 'package:my_tech_lib/app/widgets/icon_custom.dart';
import 'package:my_tech_lib/app/widgets/textField_custom.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/views/project/create_project_screen.dart';

void main() {
  testWidgets('Create Project Widget Test', (WidgetTester tester) async {
    Library library = Library(
    );

    await tester.pumpWidget(MaterialApp(
      home: CreateProjectWidget(library),
      onGenerateRoute: AppRouter.generateRoute,
    ));

    expect(find.text('Nouveau projet'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(IconCustom), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.byType(CustomDropDown), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    await tester.enterText(find.byType(CustomTextField).first, 'Nom du projet');
    await tester.enterText(find.byType(CustomTextField).last, 'Description du projet');

    await tester.tap(find.byType(CustomDropDown));
    await tester.pumpAndSettle();
    await tester.tap(find.text('MOBILE').last);
    await tester.pumpAndSettle();


    expect(find.text('Nom du projet'), findsOneWidget);
    expect(find.text('Description du projet'), findsOneWidget);
    expect(find.text('MOBILE'), findsOneWidget);


  });
}
