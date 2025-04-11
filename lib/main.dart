import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
