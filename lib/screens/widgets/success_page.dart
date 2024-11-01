import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool _isAnimationComplete = false;

  @override
  void initState() {
    super.initState();
    _playAnimation();
  }

  void _playAnimation() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      _isAnimationComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Added to prevent overflow
          child: Padding( // Added padding
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), // Added top spacing
                // Success Animation with working URL
                Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_uu0x8lqv.json',
                  height: 200,
                  repeat: false,
                  onLoaded: (composition) {
                    // Optional: Handle loading completion
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.green[700],
                    );
                  },
                ),
                
                // Success Message
                AnimatedOpacity(
                  opacity: _isAnimationComplete ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your submission has been received',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 100),
                
                // Back Button
                AnimatedOpacity(
                  opacity: _isAnimationComplete ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButtonWidget(title: "back to home", onPressed: (){
                      navigator?.pop(context);
                    })
                  ),
                ),
                SizedBox(height: 20), // Added bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
