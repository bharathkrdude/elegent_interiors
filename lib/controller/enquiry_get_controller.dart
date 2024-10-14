import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnquiryGetController extends GetxController {
  var enquiries = <dynamic>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEnquiries();
  }

  Future<void> fetchEnquiries() async {
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';

      final response = await http.get(
        Uri.parse('https://elegantinteriors.in/demo/api/v1/get-enquiry'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          enquiries.assignAll(data['enquiries']);
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to fetch enquiries');
        }
      } else {
        Get.snackbar('Error', 'Error: ${response.statusCode}');
      }
    } finally {
      isLoading(false);
    }
  }
}
