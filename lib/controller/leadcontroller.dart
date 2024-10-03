import 'dart:convert';
import 'package:elegant_interiors/model/leads_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeadController {
  final String apiUrl = 'http://cafarde.in/api/leads-list';

  Future<String> _getBearerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Use the key under which you saved the token
  }

  Future<LeadResponse> fetchLeads() async {
    try {
      String bearerToken = await _getBearerToken(); // Fetch token from SharedPreferences
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return LeadResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load leads');
      }
    } catch (e) {
      throw Exception('Error fetching leads: $e');
    }
  }
}
