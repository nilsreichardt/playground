import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  group('Example', () {
    testWidgets('should show the counter app', (tester) async {
      await tester.pumpWidget(const MyApp());

      // This is required prior to taking the screenshot (Android only).
      await binding.convertFlutterSurfaceToImage();

      // Trigger a frame.
      await tester.pumpAndSettle();
      final bytes = await binding.takeScreenshot('screenshot-1');

      await expectLater(bytes, matchesGoldenFile('screenshot-1.png'));
    });
  });
}
