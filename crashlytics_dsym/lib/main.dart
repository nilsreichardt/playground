import 'dart:async';

import 'package:crashlytics_dsym/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const _MyApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
            child: const Text('Crash!'),
          ),
        ),
      ),
    );
  }
}
