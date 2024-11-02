import 'dart:convert';



import 'package:http/http.dart' as http;

import '../screens/leads/leads_data_screen.dart';
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

static Future<Map<String, dynamic>> fetchDashboardData() async {
    String? token = await AuthService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }

    print('Dashboard Token: $token'); // Debugging line

    final url = Uri.parse('https://elegantinteriors.in/demo/api/v1/get-dashboard');
    final response = await _authenticatedRequest(url, token);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response for Dashboard: $data'); // Debugging line
      return data;
    } else {
      print('Failed to load dashboard data: ${response.reasonPhrase}'); // Debugging line
      throw Exception('Failed to load dashboard data: ${response.reasonPhrase}');
    }
  }

  static Future<http.Response> _authenticatedRequest(Uri url, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    print('Request Headers for Dashboard: $headers'); // Debugging line

    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      print('Unauthorized error on Dashboard API: ${response.body}'); // Debugging line
      bool refreshed = await AuthService.refreshToken();
      if (refreshed) {
        String? newToken = await AuthService.getToken();
        if (newToken != null) {
          headers['Authorization'] = 'Bearer $newToken';
          print('New Token after refresh: $newToken'); // Debugging line
          response = await http.get(url, headers: headers);
        }
      }
    }
    return response;
  }
}
