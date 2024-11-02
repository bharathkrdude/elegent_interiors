// import 'package:elegant_interiors/core/color.dart';
// import 'package:elegant_interiors/screens/splash/screen_splash.dart';
// import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         final response = await http.post(
//           Uri.parse('https://cafarde.in/api/login'),
//           body: {
//             'email': _emailController.text,
//             'password': _passwordController.text,
//           },
//         );

//         setState(() {
//           _isLoading = false;
//         });

//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data['token'] != null) {
//             await _saveToken(data['token']);
//             _showMessage('Login Successful');
//             Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SplashScreen()),
//         );
//           } else {
//             _showMessage('Login failed: ${data['message']}');
//           }
//         } else {
//           _showMessage('Login failed. Please try again.');
//         }
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//         });
//         _showMessage('An error occurred. Please try again later.');
//       }
//     }
//   }

//   Future<void> _saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', 'Bearer $token');
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(color: white),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 40),
//                     Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const SizedBox(height: 40,),
//                           Image.asset(
//                             'assets/images/eham.webp',
//                             height: 40,
//                             alignment: Alignment.center,
//                           ),
//                           const SizedBox(height: 60),
//                           Image.asset(
//                             'assets/images/elegant-logo-removebg-preview.png',
//                             height: 100,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     TextFormField(
//                       controller: _emailController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter email address',
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.normal,
//                         ),
//                         fillColor: elegentGrey,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter a valid password';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter password',
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.normal,
//                         ),
//                         fillColor: elegentGrey,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     _isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : PrimaryButtonWidget(title: "Login", onPressed: _login)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/bottom_navigation/bottomnavigation_widget.dart';
import 'package:elegant_interiors/screens/bottom_navigation/temp.dart';
import 'package:elegant_interiors/screens/leads/leads_data_screen.dart';
import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true; // State variable to toggle password visibility

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool success = await AuthService.login(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/eham.webp',
                      height: 40,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 60),
                    Image.asset(
                      'assets/images/elegentlogo.webp',
                      height: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.normal,
                  ),
                  fillColor: backgroundColorlightgrey.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue),
                    
                  ),
                   enabledBorder: OutlineInputBorder( // Border when not focused
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
    focusedBorder: OutlineInputBorder( // Border when focused
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword, // Use the state variable here
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.normal,
                  ),
                  fillColor: backgroundColorlightgrey.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                   enabledBorder: OutlineInputBorder( // Border when not focused
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
    focusedBorder: OutlineInputBorder( // Border when focused
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[600]!),
    ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility // Show icon when password is hidden
                          : Icons.visibility_off, // Hide icon when password is visible
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; // Toggle password visibility
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : PrimaryButtonWidget(
                      onPressed: _login,
                      title: "Login",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}