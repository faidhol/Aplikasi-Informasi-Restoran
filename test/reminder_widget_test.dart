import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting/reminder_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Toggle reminder switch test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ReminderProvider(reminderScheduler: (_) async => true),
        child: MaterialApp(
          home: Scaffold(
            body: Consumer<ReminderProvider>(
              builder: (context, provider, _) {
                return Switch(
                  value: provider.isEnabled,
                  onChanged: (value) {
                    provider.toggleReminder(value);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Switch), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
  });
}