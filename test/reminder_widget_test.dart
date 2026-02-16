import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting/reminder_provider.dart';

void main() {
  testWidgets('Toggle reminder switch test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ReminderProvider(),
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
    await tester.pump();
  });
}
