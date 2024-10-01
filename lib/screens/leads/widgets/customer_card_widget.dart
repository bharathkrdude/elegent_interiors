import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/quotation/widgets/customer_quotationcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final String phoneNumber;
  final VoidCallback onCardTap; // Tap for the entire card
  final VoidCallback onCallPressed; // Tap for call button

  const CustomerCardWidget(
      {Key? key,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.onCallPressed,
      required this.onCardTap})
      : super(key: key);

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCardTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                          Icon(Icons.location_on_outlined,color: elegantRedColor,size: 12,),
                          SizedBox(width: 5,),
                          Text(
                          address,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 callButtonWidget(onCallPressed: onCallPressed)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
