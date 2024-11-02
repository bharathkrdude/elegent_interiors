


// import 'package:elegant_interiors/controller/leadcontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PaginationControls extends StatelessWidget {
//   final LeadDataController controller;

//   const PaginationControls({Key? key, required this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         int totalPages = controller.totalPages;
//         if (totalPages <= 1) {
//           return SizedBox.shrink(); // Hide pagination if only one page
//         }

//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 controller.goToPreviousPage(); // Go to previous page
//               },
//               color: controller.currentPage.value > 0 ? Colors.black : Colors.grey,
//             ),
//             ...List.generate(totalPages, (index) {
//               return GestureDetector(
//                 onTap: () {
//                   controller.currentPage.value = index; // Set the selected page
//                   controller.updateDisplayedLeads(); // Update displayed leads for the selected page
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: controller.currentPage.value == index ? Colors.blue : Colors.grey[300],
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: Text(
//                     (index + 1).toString(),
//                     style: TextStyle(
//                       color: controller.currentPage.value == index ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//             IconButton(
//               icon: Icon(Icons.arrow_forward),
//               onPressed: () {
//                 controller.goToNextPage(); // Go to next page
//               },
//               color: (controller.currentPage.value + 1) * controller.itemsPerPage < controller.filterLeads(controller.allLeads).length ? Colors.black : Colors.grey,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }