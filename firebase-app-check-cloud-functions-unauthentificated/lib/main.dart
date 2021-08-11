import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<HttpsCallableResult<String>>(
              future: FirebaseFunctions.instance
                  .httpsCallable('helloWorld')
                  .call<String>(),
              builder: (context, future) {
                if (future.hasError)
                  return Text(future.error?.toString() ?? "Error");

                if (!future.hasData) return CircularProgressIndicator();

                final result = future.data;
                return Text(result!.data);
              }),
        ),
      ),
    );
  }
}
