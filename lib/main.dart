import 'package:a/screens/createaccaountscreen.dart';
import 'package:a/screens/menuplanta.dart';
// Ensure that Plant1 is defined and exported from menuplanta.dart
import 'package:a/screens/menuscreen.dart';
import 'package:a/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:a/screens/loginscreen.dart';
import 'package:a/screens/armarioscreen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const EcologicPoint());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class EcologicPoint extends StatelessWidget {
  const EcologicPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(body: LogIn()),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LogIn(),
        '/home': (context) => Home(),
        '/createacc': (context) => CreateAcc(),
        '/planta': (context) => Plant1(),
        '/armario': (context) => ArmarioScreen(),
      },
      // home: Scaffold(body: ListView(children: [Welcome()])),
    );
  }
}
