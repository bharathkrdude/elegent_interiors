import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnquiryForm extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Form', style: TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.red.shade50],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'We\'d love to hear from you!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red.shade800),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomTextField(
                  label: 'First Name',
                  icon: Icons.person_outline,
                  onSaved: (value) => _formData['firstName'] = value,
                  validator: requiredValidator,
                ),
                CustomTextField(
                  label: 'Last Name',
                  icon: Icons.person_outline,
                  onSaved: (value) => _formData['lastName'] = value,
                  validator: requiredValidator,
                ),
                CustomTextField(
                  label: 'Email Address (Optional)',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _formData['email'] = value,
                  validator: emailValidator,
                ),
                CustomTextField(
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  prefixText: '+91 ',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) => _formData['phone'] = value,
                  validator: requiredValidator,
                ),
                CustomTextField(
                  label: 'Address',
                  icon: Icons.home_outlined,
                  maxLines: 3,
                  onSaved: (value) => _formData['address'] = value,
                  validator: requiredValidator,
                ),
                CustomDropdownField(
                  label: 'Enquiry About',
                  icon: Icons.help_outline,
                  items: ['Kitchen Design', 'Interior Decoration', 'Renovation', 'Other'],
                  onChanged: (value) => _formData['enquiryAbout'] = value,
                  validator: requiredValidator,
                ),
                CustomDropdownField(
                  label: 'How Did You Find Us?',
                  icon: Icons.search,
                  items: ['Google', 'Social Media', 'Referral', 'Other'],
                  onChanged: (value) => _formData['howDidYouFindUs'] = value,
                  validator: requiredValidator,
                ),
                SizedBox(height: 32),
                CustomButton(
                  label: 'Submit',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process form data
      print(_formData);
      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thank You!'),
            content: Text('Your enquiry has been submitted successfully. We\'ll get back to you soon.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _formKey.currentState!.reset();
                  setState(() => _formData.clear());
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.prefixText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    required this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.red.shade300),
          prefixText: prefixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.red.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        primary: Colors.red.shade600,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
    );
  }
}

String? requiredValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value != null && value.isNotEmpty) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
  }
  return null;
}
