// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text("Firebase Auth Web Bug")),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
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
            return _Login();
          },
        ),
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
            onChanged: (e) => email = e,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            onChanged: (p) => password = p,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            TextButton(
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
