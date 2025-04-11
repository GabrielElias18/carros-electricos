import 'package:flutter/material.dart';
import '../models/carro.dart';

class CarDetailScreen extends StatelessWidget {
  final Carro carro;
  const CarDetailScreen({super.key, required this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Carro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(carro.imagen),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text('Conductor: ${carro.conductor}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Placa: ${carro.placa}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('ID: ${carro.id}', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
