import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://carros-electricos.wiremockapi.cloud/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token') && data['token'].isNotEmpty) {
        return data['token']; // ✅ Token válido
      }
    }

    return null; // ❌ Error de autenticación
  }
}
