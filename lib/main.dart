import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:reflective_ui/views/views.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  changeTheme({required ThemeMode themeMode}) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Reflective UI',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          secondary: Colors.black12,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(
          brightness: Brightness.dark,
          secondary: Colors.white12,
        ),
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        updateTheme: () => changeTheme(
          themeMode:
              _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
        ),
      ),
    );
  }
}
