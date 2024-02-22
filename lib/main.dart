import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/ui/initial_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Member App',
      home: SplashScreen(),
    );
  }
}
