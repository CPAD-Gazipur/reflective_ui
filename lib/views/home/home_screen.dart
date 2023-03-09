import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reflective_ui/main.dart';

class HomeScreen extends StatefulWidget {
  final Function updateTheme;

  const HomeScreen({
    Key? key,
    required this.updateTheme,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraController? cameraController;

  int cameraIndex = 0;

  _startCamera() {
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint('[Camera] Access Denied');
            break;
          default:
            debugPrint('[Camera] ${e.code}');
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (cameras.length > 1) {
      cameraIndex = kIsWeb ? 1 : 0;
    }

    cameraController = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    _startCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).primaryColor,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Theme.of(context).brightness,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: cameraController != null && cameraController!.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(cameraController!),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4,
                    sigmaY: 4,
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
