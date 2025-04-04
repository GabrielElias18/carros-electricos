import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/car_services.dart';

class CarListScreen extends StatefulWidget {
  final String token;

  CarListScreen({required this.token});

  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  List<dynamic> cars = [];
  bool isLoading = true;

  Future<void> _fetchCars() async {
    print("Token recibido: ${widget.token}");

    List<dynamic> fetchedCars = await CarService.getCars(widget.token);

    print("Carros obtenidos (formato JSON):");
    print(JsonEncoder.withIndent('  ').convert(fetchedCars));

    setState(() {
      cars = fetchedCars;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Carros'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cars.isEmpty
              ? const Center(
                  child: Text('No se encontraron carros.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final carro = cars[index];
                    final imagenOriginal = carro['imagen'] ?? '';
                    final imagenUrl = 'https://api.allorigins.win/raw?url=$imagenOriginal';

                    return Card(
                      color: Colors.grey[900],
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imagenUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(strokeWidth: 2),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[800],
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Placa: ${carro['placa']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Conductor: ${carro['conductor']}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
