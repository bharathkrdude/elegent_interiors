import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class FormController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var enquiry = ''.obs;
  var howDidYouFindUs = ''.obs;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acces_token');
  }

  void submitForm() async {
    try {
      String? token = await getToken();
      if (token == null) {
        Get.snackbar('Error', 'No token found. Please login again.');
        return;
      }

      var response = await http.post(
        Uri.parse('https://elegantinteriors.in/demo/api/v1/store'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': firstName.value,
          'last_name': lastName.value,
          'email': email.value,
          'phone': phone.value,
          'address': address.value,
          'enquiry': enquiry.value,
          'how_did_you_find_us': howDidYouFindUs.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Form submitted successfully');
      } else {
        Get.snackbar('Error', 'Failed to submit form: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
