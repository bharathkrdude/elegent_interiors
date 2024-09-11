import 'package:elegant_interiors/screens/enquiry_form.dart';
import 'package:elegant_interiors/screens/form_three.dart';
import 'package:elegant_interiors/screens/widgets/form_design.dart';
import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

class TempPage extends StatelessWidget {
   TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButtonWidget(title: "form one", onPressed: (){ Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  Formdesign(),
          ),
              );}),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButtonWidget(title: "form two", onPressed: (){ Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  EnquiryForm(),
          ),
              );}),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButtonWidget(title: "form three", onPressed: (){ Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  (EnquiryForm3()),
          ),
              );}),
        ),
      ],
      ),
    );
  }
}