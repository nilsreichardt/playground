import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Builder(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Demo of opening a link after awaiting a Future'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loading...'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Simulate loading
                    await Future.delayed(const Duration(seconds: 3));

                    launchUrl(
                      Uri.parse(
                          'https://github.com/nilsreichardt/playground/blob/main/flutter_web_async_link/lib/main.dart'),
                      webOnlyWindowName: '_self',
                    );
                  },
                  child: const Text('Open code example'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
