import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app test - toggle reminder', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    app.main(isTest: true);
    await tester.pumpAndSettle();

    final settingButtonFinder = find.byIcon(Icons.settings);
    expect(settingButtonFinder, findsOneWidget);

    await tester.tap(settingButtonFinder);
    await tester.pumpAndSettle();

    final allSwitchesFinder = find.byType(Switch);
    expect(allSwitchesFinder, findsNWidgets(2));

    final reminderSwitchFinder = allSwitchesFinder.last;
    final reminderBefore = tester.widget<Switch>(reminderSwitchFinder);
    expect(reminderBefore.value, isFalse);

    await tester.tap(reminderSwitchFinder);
    await tester.pumpAndSettle();

    final reminderAfter = tester.widget<Switch>(reminderSwitchFinder);
    expect(reminderAfter.value, isTrue);
  });
}