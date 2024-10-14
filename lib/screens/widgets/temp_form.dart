import 'package:elegant_interiors/controller/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormView extends StatelessWidget {
  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enquiry Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => controller.firstName.value = value,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                onChanged: (value) => controller.lastName.value = value,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                onChanged: (value) => controller.email.value = value,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                onChanged: (value) => controller.phone.value = value,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                onChanged: (value) => controller.address.value = value,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                onChanged: (value) => controller.enquiry.value = value,
                decoration: InputDecoration(labelText: 'Enquiry'),
              ),
              TextFormField(
                onChanged: (value) => controller.howDidYouFindUs.value = value,
                decoration: InputDecoration(labelText: 'How did you find us?'),
              ),
              ElevatedButton(
                onPressed: controller.submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
