import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EnquiryDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String enquiryAbout;
  final String foundThrough;
  final String enquiryDate;
  final VoidCallback? onEdit;
  final VoidCallback? onContact;

  const EnquiryDetailsPage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.enquiryAbout,
    required this.foundThrough,
    required this.enquiryDate,
    this.onEdit,
    this.onContact,
  }) : super(key: key);

 @override
Widget build(BuildContext context) {
  // Parse the date string to DateTime
  DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(enquiryDate);
  
  // Format the DateTime object to a readable string
  String formattedDate = DateFormat('MMMM d, y').format(parsedDate); // e.g., "October 20, 2023"

  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Enquiry Details',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: elegantRedColor),
      ),
      backgroundColor: white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today, 'Enquiry Date: $formattedDate'), // Use formatted date here
          _buildInfoRow(Icons.email_outlined, email),
          _buildInfoRow(Icons.phone_outlined, phone),
          _buildInfoRow(Icons.home_outlined, address),
          const SizedBox(height: 24),
          Text(
            'Enquiry Details',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.help_outline, 'Enquiry About: $enquiryAbout'),
          _buildInfoRow(Icons.search, 'Found Us Through: $foundThrough'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButtonWidget(
                    title: "Back",
                    onPressed: () {
                      Navigator.pop(context); // Handle back navigation
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SecondaryButtonWidget(
                    title: "Contact",
                    onPressed: onContact ?? () {
                      // Default action for contact (e.g., call or message)
                      print('Contacting $name');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: elegantRedColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
