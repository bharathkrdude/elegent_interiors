import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio; // Using alias for dio
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  var userData = {}.obs;
  var isLoading = false.obs;

  final dio.Dio _dio = dio.Dio(); // Using alias for dio
  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar("Error", "Token not found. Please log in again.");
        return;
      }

      final response = await _dio.get(
        'https://elegantinteriors.in/demo/api/v1/get-user',
        options: dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        userData.value = response.data['user'];
      } else {
        Get.snackbar("Error", "Failed to fetch user data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar("Error", "Token not found. Please log in again.");
        return;
      }

      // Create form data with the image file
      dio.FormData formData = dio.FormData.fromMap({
        'profile_image': await dio.MultipartFile.fromFile(imageFile.path, filename: 'profile.jpg'),
      });

      final response = await _dio.post(
        'https://elegantinteriors.in/demo/api/v1/update-profile',
        data: formData,
        options: dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        Get.snackbar("Success", "Profile image updated successfully");
        fetchUserData(); // Refresh user data after updating profile image
      } else {
        Get.snackbar("Error", response.data['message'] ?? "Failed to update profile image");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
  
}
