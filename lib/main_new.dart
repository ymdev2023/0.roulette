import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const AdjectiveLaboratoryApp());
}

class AdjectiveLaboratoryApp extends StatelessWidget {
  const AdjectiveLaboratoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'adjective Laboratory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        fontFamily: 'Courier New',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Courier New'),
          displayMedium: TextStyle(fontFamily: 'Courier New'),
          displaySmall: TextStyle(fontFamily: 'Courier New'),
          headlineLarge: TextStyle(fontFamily: 'Courier New'),
          headlineMedium: TextStyle(fontFamily: 'Courier New'),
          headlineSmall: TextStyle(fontFamily: 'Courier New'),
          titleLarge: TextStyle(fontFamily: 'Courier New'),
          titleMedium: TextStyle(fontFamily: 'Courier New'),
          titleSmall: TextStyle(fontFamily: 'Courier New'),
          bodyLarge: TextStyle(fontFamily: 'Courier New'),
          bodyMedium: TextStyle(fontFamily: 'Courier New'),
          bodySmall: TextStyle(fontFamily: 'Courier New'),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
