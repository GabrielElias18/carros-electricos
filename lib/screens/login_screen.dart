import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuarioCtrl = TextEditingController();
  final claveCtrl = TextEditingController();
  String error = '';

  void _login() {
    if (usuarioCtrl.text == 'admin' && claveCtrl.text == 'admin') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      setState(() {
        error = 'Usuario o contraseña incorrecta';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: usuarioCtrl, decoration: InputDecoration(labelText: 'Usuario')),
            TextField(controller: claveCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Contraseña')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Ingresar')),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
