import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnquiryDetailsCard extends StatelessWidget {
  
  final String name;
  final String email;
  final String phone;
  final String address;
  final String enquiryAbout;
  final String foundThrough;
  final DateTime enquiryDate;
  final VoidCallback? onEdit;
  final VoidCallback? onContact;

  const EnquiryDetailsCard({
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
    return Expanded(
      child: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today, 'Enquiry Date: ${DateFormat('MMMM d, y').format(enquiryDate)}'),
                  _buildInfoRow(Icons.email_outlined, email),
                  _buildInfoRow(Icons.phone_outlined, phone),
                  _buildInfoRow(Icons.home_outlined, address),
                  SizedBox(height: 24),
                  Text(
                    'Enquiry Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: elegantRedColor),
                  ),
                  SizedBox(height: 16),
                  _buildInfoRow(Icons.help_outline, 'Enquiry About: $enquiryAbout'),
                  _buildInfoRow(Icons.search, 'Found Us Through: $foundThrough'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SecondaryButtonWidget(
                          title: "Back",
                          onPressed: (){},
                          color: elegantBackgroundColor,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SecondaryButtonWidget(
                          color: elegantBackgroundColor,
                          title: "Contact",
                          onPressed: (){},
                        ),
                      ),
                    ],
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
          Icon(icon, size: 24, color: elegantBackgroundColor),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
