import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<List<CameraDescription>>(
          future: availableCameras(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final cameras = snapshot.data!;
              log('Found cameras: $cameras');
              return CameraApp(cameras: cameras);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraApp({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller);
  }
}
