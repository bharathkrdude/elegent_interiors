import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnquiryController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var firstName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var enquiryAbout = 'Kitchen Design'.obs;
  var howDidYouFindUs = 'Google'.obs;

  // Updates fields when form values change
  void updateField(String field, String? value) {
    if (value != null) {
      switch (field) {
        case 'firstName':
          firstName.value = value;
          break;
        case 'email':
          email.value = value;
          break;
        case 'phone':
          phone.value = value;
          break;
        case 'address':
          address.value = value;
          break;
        case 'enquiryAbout':
          enquiryAbout.value = value;
          break;
        case 'howDidYouFindUs':
          howDidYouFindUs.value = value;
          break;
      }
    }
  }

  // Submits the enquiry form
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await http.post(
        Uri.parse('https://elegantinteriors.in/demo/api/v1/store'),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'first_name': firstName.value,
          'email': email.value,
          'phone': phone.value,
          'address': address.value,
          'enquiry_about': enquiryAbout.value,
          'how_did_you_find_us': howDidYouFindUs.value,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          Get.snackbar('Success', 'Enquiry submitted successfully');
          Get.back();  // Go back to the previous page
        } else {
          Get.snackbar('Error', 'Submission failed: ${data['message']}');
        }
      } else {
        Get.snackbar('Error', 'Error: ${response.statusCode}');
      }
    }
  }
}