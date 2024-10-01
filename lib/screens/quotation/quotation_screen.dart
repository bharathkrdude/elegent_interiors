import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/quotation/widgets/customer_quotationcard_widget.dart';
import 'package:flutter/material.dart';

class QuotationScreen extends StatelessWidget {
  const QuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CustomerQuotationTile(
                name: "Joseph Francis",
                amount: "500000",
                commission: "36000",
                onTap: () {}, onCallPressed: () {  },),
                 CustomerQuotationTile(
                name: "Ajay Chandran",
                amount: "500000",
                commission: "36000",
                onTap: () {}, onCallPressed: () {  },),
                 CustomerQuotationTile(
                name: "joseph",
                amount: "500000",
                commission: "36000",
                onTap: () {}, onCallPressed: () {  },),
                 CustomerQuotationTile(
                name: "joseph",
                amount: "500000",
                commission: "36000",
                onTap: () {}, onCallPressed: () {  },),
          ],
        ),
      ),
    );
  }
}