import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/api_service.dart';
import '../models/carro.dart';
import './car_details_screen.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool yaEscaneado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanea el QR')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (yaEscaneado) return;
      yaEscaneado = true;

      final idEscaneado = scanData.code?.trim(); // ID del carro

      if (idEscaneado == null || idEscaneado.isEmpty) {
        _mostrarError('Código QR inválido');
        return;
      }

      try {
        final carros = await ApiService.obtenerCarros();

        final carro = carros.firstWhere(
          (c) => c.id == idEscaneado,
          orElse: () => throw Exception('No se encontró el carro con ID $idEscaneado'),
        );

        controller.pauseCamera();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CarDetailScreen(carro: carro),
          ),
        );
      } catch (e) {
        _mostrarError(e.toString());
        yaEscaneado = false;
      }
    });
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
