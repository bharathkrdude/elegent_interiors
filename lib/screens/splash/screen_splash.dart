import 'dart:async';

import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/enquiry_form.dart';
import 'package:elegant_interiors/screens/temp.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  TempPage(),
        ),
      );
    });
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
