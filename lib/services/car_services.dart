import 'package:http/http.dart' as http;
import 'dart:convert';

class CarService {
  static Future<List<dynamic>> getCars(String token) async {
    final response = await http.get(
      Uri.parse('https://carros-electricos.wiremockapi.cloud/carros'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
// 👈 OJO: esta cabecera debe coincidir con lo que pide la API
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error al obtener los carros. Código: ${response.statusCode}');
      print('Respuesta: ${response.body}');
      print(token);
      return [];
    }
  }
}
