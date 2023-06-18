import 'package:playground/src/providers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

void main() {
  test('should not fail', () {
    final container = ProviderContainer();

    container.read(searchProvider.notifier).set('Hello');
    final list1 = container.read(myListProvider);

    container.read(searchProvider.notifier).set('World');
    final list2 = container.read(myListProvider);
  });
}
