import 'package:elegant_interiors/screens/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter

class EnquiryForm3 extends StatefulWidget {
  @override
  _EnquiryForm3State createState() => _EnquiryForm3State();
}

class _EnquiryForm3State extends State<EnquiryForm3> {
  final _formKey = GlobalKey<FormState>();
  String? _enquiryOption;
  String? _findUsOption;
  final List<String> _enquiryOptions = ['Civil kitchen', 'Modular kitchen'];
  final List<String> _findUsOptions = ['Online', 'Referral', 'Advertisement'];

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _enquiryController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _enquiryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submitted')),
      );
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enquiry Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First Name and Last Name heading
              Text('First Name', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // First Name and Last Name in the same row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Email Address heading
              Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // Email Field (Optional)
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),

              // Phone Number heading
              Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validatePhoneNumber,
              ),
              SizedBox(height: 16.0),

              // Address heading
              Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Enquiry About heading
              Text('Enquiry About', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // Enquiry About Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select an Option',
                  border: OutlineInputBorder(),
                ),
                value: _enquiryOption,
                items: _enquiryOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _enquiryOption = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // How did you find us heading
              Text('How did you find us', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),

              // How did you find us Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select an Option',
                  border: OutlineInputBorder(),
                ),
                value: _findUsOption,
                items: _findUsOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _findUsOption = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),

              // Submit Button
              PrimaryButtonWidget(
                title: "Submit",
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
