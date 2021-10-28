import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:multiple_integration_tests/main.dart';

// Command to run:
// flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await init();
    await FirebaseAuth.instance.signOut();
  });

  testWidgets('first login', (tester) async {
    await pumpAndLogin(tester);
  });

  testWidgets('second login', (tester) async {
    await pumpAndLogin(tester);
  });
}

Future<void> pumpAndLogin(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pump();

  // Enter credentails
  await tester.enterText(
    find.byKey(const Key('email-field')),
    'test@account.com',
  );
  await tester.enterText(
    find.byKey(const Key('password-field')),
    '12345678',
  );

  // Press login button
  await tester.tap(find.byKey(const Key('login-button')));

  // Wait to login
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('authenticated-view')), findsOneWidget);
}
