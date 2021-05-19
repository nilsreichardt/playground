import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: Text("Paste into Clipboard"),
                    onPressed: () async {
                      const flutterIsAwesome = "Flutter is awesome!";
                      await Clipboard.setData(ClipboardData(text: flutterIsAwesome));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Pasted '$flutterIsAwesome' into clipboard"),
                      ));
                    },
                  ),
                  ElevatedButton(
                    child: Text("Copy from Clipboard"),
                    onPressed: () async {
                      final clipboardData = await Clipboard.getData("text/plain");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(clipboardData?.text ?? "null")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
