import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Firebase Auth")),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) return const _AuthenticatedView();
            return _Login();
          },
        ),
      ),
    );
  }
}

class _AuthenticatedView extends StatelessWidget {
  const _AuthenticatedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('authenticated-view'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Signed in."),
          const SizedBox(height: 18),
          const Divider(),
          TextButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text("Sign out"),
          )
        ],
      ),
    );
  }
}

class _Login extends StatefulWidget {
  @override
  __LoginState createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            key: const Key('email-field'),
            onChanged: (e) => email = e,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            key: const Key('password-field'),
            onChanged: (p) => password = p,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            TextButton(
              key: const Key('login-button'),
              onPressed: () {
                setState(() => isLoading = true);
                FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email!,
                  password: password!,
                );
              },
              child: const Text("Login"),
            )
        ],
      ),
    );
  }
}
