import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/carro.dart';
import 'qr_scan_screen.dart';
import './car_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Carros Eléctricos'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => QRScanScreen()),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Carro>>(
        future: ApiService.obtenerCarros(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final carros = snapshot.data!;
            return ListView.builder(
              itemCount: carros.length,
              itemBuilder: (context, index) {
                final carro = carros[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(carro.imagen),
                      radius: 25,
                    ),
                    title: Text(carro.conductor),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Placa: ${carro.placa}'),
                        Text('ID: ${carro.id}'),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailScreen(carro: carro),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
