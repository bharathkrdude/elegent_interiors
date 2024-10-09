import 'package:elegant_interiors/screens/dashboard/dash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  final List<String> cardTitles = [
    'Delivered',
    'Open Rate',
    'Click Rate',
    'Source',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // To avoid scrolling inside the grid
                  shrinkWrap: true, // Important to ensure GridView takes only the required height
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Display two items per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5, // Adjust height based on width
                  ),
                  itemCount: cardTitles.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => DashCard(
                        title: cardTitles[index],
                        subtitle: controller.cardSubtitles[index],
                        additionalText: controller.cardAdditionalTexts[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashCard extends StatelessWidget {
  const DashCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.additionalText,
  });

  final String title;
  final String subtitle;
  final String additionalText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 25), // Space between subtitle and additional text
                Text(
                  "+$additionalText",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
