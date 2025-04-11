import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/carro.dart';

class ApiService {
  static const String baseUrl = 'https://67f7d1812466325443eadd17.mockapi.io/carros';

  static Future<List<Carro>> obtenerCarros() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Carro.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener carros');
    }
  }

  static Future<Carro> obtenerCarroPorQR(String qr) async {
    final response = await http.get(Uri.parse('$baseUrl/$qr'));
    if (response.statusCode == 200) {
      return Carro.fromJson(json.decode(response.body));
    } else {
      throw Exception('Carro no encontrado');
    }
  }
}
