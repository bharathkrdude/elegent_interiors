import 'package:elegant_interiors/controller/quotaton/quotation_controller.dart';
import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/quotation/widgets/customer_quotationcard_widget.dart';
import 'package:elegant_interiors/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class QuotationScreen extends StatelessWidget {
  QuotationScreen({super.key});

  final QuotationController controller = Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: backgroundColorlightgrey,
      appBar: const CustomAppBar(title: 'Quotation'),
     
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListView.builder(
              itemCount: controller.quotations.length,
              itemBuilder: (context, index) {
                final quotation = controller.quotations[index];
                final phoneNumber = quotation['phone']; // Assuming you have a phone number in your data

                return CustomerQuotationTile(
                  name: "${quotation['first_name']} ${quotation['last_name']}",
                  amount: "${quotation['amount']}",
                  commission: "${quotation['commission_amount']}",
                  onTap: () {},
                  onCallPressed: () async {
                    if (phoneNumber != null && phoneNumber.isNotEmpty) {
                      try {
                        await FlutterPhoneDirectCaller.callNumber(phoneNumber);
                      } catch (e) {
                        print("Error making call: $e");
                      }
                    } else {
                      print("Phone number is not available.");
                    }
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
