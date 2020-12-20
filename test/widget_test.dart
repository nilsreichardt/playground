import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('DocumentReference', () async {

    final name = 'foo';
    final firebaseOptions = const FirebaseOptions(
      appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
      apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
      projectId: 'react-native-firebase-testing',
      messagingSenderId: '448618578101',
    );

    await Firebase.initializeApp(name: name, options: firebaseOptions);

    final ref1 = FirebaseFirestore.instance.collection('test').doc('doc1');
    final ref2 = FirebaseFirestore.instance.collection('test').doc('doc1');

    expect(ref1, ref2);
  });
}

ex
