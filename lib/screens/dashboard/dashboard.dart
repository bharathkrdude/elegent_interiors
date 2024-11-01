import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/dashboard/dash_controller.dart';
import 'package:elegant_interiors/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      appBar:const CustomAppBar(title: 'Dashboard'),
      body: Obx(() {
        // Loading Indicator
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Error Handling
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }

        final data = controller.dashboardModel.value.data;

        // Check if data is null or not
        if (data == null) {
          return Center(child: Text('No data available'));
        }

        return Padding(
          padding: const EdgeInsets.only(top: 40,left: 14, right: 14),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5, // Adjust this for card aspect ratio
            children: [
                DashCard(
                title: 'Quotation Amount',
                subtitle: '${data.quotationAmount?.toString() ?? '0'}', imagepath: 'assets/images/money_631149.png',
              ),
              DashCard(
                title: 'Commission Amount',
                subtitle: '${data.commissionAmount.toString()?? '0'}', imagepath: 'assets/images/pay_625599.png',
              ),
              DashCard(
                title: 'Number of Leads',
                subtitle: data.noOfLeads?.toString() ?? '0', imagepath: 'assets/images/group_542751.png',
              ),
              DashCard(
                title: 'Number of Customers',
                subtitle: data.noOfCustomers?.toString() ?? '0', imagepath: 'assets/images/satisfaction_1165721.png',
              ),
            
            ],
          ),
        );
      }),
    );
  }
}

class DashCard extends StatelessWidget {
  const DashCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.additionalText, required this.imagepath, // Optional parameter
  }) : super(key: key);
final String imagepath;
  final String title;
  final String subtitle;
  final String? additionalText; // Make additionalText optional

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white, // Background color of the container
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 1, // Spread radius for shadow
            blurRadius: 5, // Blur radius for shadow
            offset: Offset(0, 3), // Offset of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          
          children: [
            
           Image.asset(imagepath,height: 20,width: 25,),
            Expanded( // Use Expanded to allow subtitle to take available space
              child: Center(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: black,
                    overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.red, // Changed text color for contrast
              ),
            ),
          ],
        ),
      ),
    );
  }
}
