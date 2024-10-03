import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/enquiry_details_page/enquiry_details_screen.dart';
import 'package:elegant_interiors/screens/leads/widgets/customer_card_widget.dart';
import 'package:flutter/material.dart';

class LeadsPage extends StatelessWidget {
  final List<Map<String, String>> customers = [
    {
      "name": "Joseph Francis",
      "address": "Sk Apartment Puthiyakavu",
      "phoneNumber": "123-456-7890",
    },
    {
      "name": "Emma Watson",
      "address": "123 Elm Street",
      "phoneNumber": "987-654-3210",
    },
    // Add more customer details as needed
  ];

LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorWhite,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Leads Page",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: CustomerCardWidget(
                name: customer['name']!,
                address: customer['address']!,
                phoneNumber: customer['phoneNumber']!,
                onCallPressed: () {},
                onCardTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EnquiryDetailsPage(
                              name: customer['name']!,
                              email: customer['address']!,
                              phone: '+1 234 567 8900',
                              address: '123 Main St, City, Country',
                              enquiryAbout: 'Kitchen Design',
                              foundThrough: 'Google Search',
                              enquiryDate: DateTime.now(),
                              onEdit: () {
                                // Handle edit action
                              },
                              onContact: () {
                                // Handle contact action
                              },
                            )),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
