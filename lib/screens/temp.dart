import 'package:elegant_interiors/screens/enquiry_form.dart';
import 'package:elegant_interiors/screens/form_three.dart';
import 'package:elegant_interiors/screens/login/screen_login.dart';
import 'package:elegant_interiors/screens/widgets/form_design.dart';
import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempPage extends StatefulWidget {
  TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  // Retrieve token from SharedPreferences
  Future<void> _loadToken() async {
    String? token = await _getToken();
    setState(() {
      _token = token;
    });
  }

  // Function to get the token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // Ensure the correct key is used
  }

  // Logout function to remove token from SharedPreferences and navigate to LoginScreen
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Ensure the correct key is used
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Trigger logout when button is pressed
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButtonWidget(
              title: "Form One",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Formdesign(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButtonWidget(
              title: "Form Two",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EnquiryForm(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButtonWidget(
              title: "Form Three",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EnquiryForm3(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
