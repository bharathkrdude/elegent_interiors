import 'dart:async';
import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/bottomNavigation/bottomnavigation_widget.dart';
import 'package:elegant_interiors/screens/login/screen_login.dart';
import 'package:elegant_interiors/screens/temp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    // Simulate a loading time for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Check if the token exists in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    // Navigate based on the presence of the token
    if (token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNavigationWidget(), // Go to TempPage if token exists
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignInPage(), // Go to SignInPage if token doesn't exist
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Image.asset(
          'assets/images/elegentlogo.webp',
        ),
      ),
    );
  }
}
