import 'package:elegant_interiors/controller/quotaton/quotation_controller.dart';
import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/quotation/widgets/customer_quotationcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuotationScreen extends StatelessWidget {
  QuotationScreen({super.key});

  final QuotationController controller = Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Center(
          child: Text(
            "Quotation",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
      backgroundColor: backgroundColorlightgrey,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.quotations.length,
            itemBuilder: (context, index) {
              final quotation = controller.quotations[index];
              return CustomerQuotationTile(
                name: "${quotation['first_name']} ${quotation['last_name']}",
                amount: "${quotation['amount']}",
                commission: "${quotation['commission_amount']}",
                onTap: () {},
                onCallPressed: () {},
              );
            },
          );
        }
      }),
    );
  }
}
