import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app test - toggle reminder',
      (WidgetTester tester) async {
    app.main(isTest: true); // 🔥 penting
    await tester.pumpAndSettle();

    // Navigasi ke Settings kalau pakai bottom nav
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();
  });
}
