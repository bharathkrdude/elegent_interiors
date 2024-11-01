import 'package:elegant_interiors/controller/user/user_controller.dart';
import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/dashboard/dash_controller.dart';
import 'package:elegant_interiors/screens/login/screen_login.dart';
import 'package:elegant_interiors/screens/profile/profile_info_tile_widget.dart';
import 'package:elegant_interiors/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final String defaultProfileImageUrl = 'https://elegantinteriors.in/demo/public/image/user-dummy-img.jpg';
  final UserController userController = Get.put(UserController());
 final DashboardController controller = Get.put(DashboardController());

  // Function to pick an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Call the method to update the profile image
      await userController.updateProfileImage(_imageFile!);
    }
  }

  // Show option to pick from camera or gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Ensure the correct key is used
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
// Utility function to convert string to camel case
  String toCamelCase(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
  @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: backgroundColorlightgrey,
    appBar: CustomAppBar(title: 'Profile'),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            onTap: _showImagePickerOptions,
            child: Obx(() {
              String? profileImageUrl = userController.userData['profile'];

              return CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (profileImageUrl != null && profileImageUrl.isNotEmpty)
                        ? NetworkImage('https://elegantinteriors.in/demo/public/images/profile/$profileImageUrl')
                        : NetworkImage(defaultProfileImageUrl) as ImageProvider,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Obx(() {
            String name = userController.userData['name'] ?? 'User Name';
            // Convert to camel case
            String camelCaseName = toCamelCase(name);
            return Text(
              camelCaseName,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: elegantRedColor,
              ),
            );
          }),
          const SizedBox(height: 60),
          Obx(() {
            // Loading Indicator
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            // Error Handling
            if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${controller.errorMessage.value}'));
            }

            final data = controller.dashboardModel.value.data;

            // Check if data is null or not
            if (data == null) {
              return Center(child: Text('No data available'));
            }

            return ProfileInfoTile(
              icon: Icons.people_alt_outlined,
              title: "Today's total leads",
              subtitle: data.noOfLeads?.toString() ?? '0',
            );
          }),
          // const Divider(height: 30, color: Colors.deepPurpleAccent),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
            title: const Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    ),
  );
}
}
