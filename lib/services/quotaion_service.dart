import 'dart:convert';

import 'package:elegant_interiors/screens/bottom_navigation/temp.dart';

import 'package:http/http.dart' as http;
class QuotationService {
  static Future<List<dynamic>> fetchQuotations() async {
    String? token = await AuthService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    final url = Uri.parse('https://elegantinteriors.in/demo/api/v1/get-quotation');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Debugging line
      if (data is Map<String, dynamic> && data.containsKey('quotation')) {
        return data['quotation'];
      } else {
        throw Exception('Unexpected data structure: ${data.keys.join(', ')}');
      }
    } else {
      throw Exception('Failed to load quotations: ${response.reasonPhrase}');
    }
  }
}
