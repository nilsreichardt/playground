import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('print the env', (tester) async {
    print("From env 1: ${String.fromEnvironment('USER_1_EMAIL')}");
    print("From env 2: ${const String.fromEnvironment('USER_1_EMAIL')}");
  });
}
