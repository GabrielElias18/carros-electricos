import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/car_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData temaClaro = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.tealAccent[700],
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.tealAccent,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850],
      labelStyle: const TextStyle(color: Colors.tealAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carros Eléctricos',
      theme: temaClaro,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/carros': (context) => const Placeholder(), // puedes registrar rutas aquí si usas navegación por nombre
      },
    );
  }
}
