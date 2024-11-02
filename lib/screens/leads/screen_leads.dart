// import 'dart:async'; // Import this for using FutureBuilder
// import 'package:elegant_interiors/controller/leadcontroller.dart';
// import 'package:elegant_interiors/core/color.dart';
// import 'package:elegant_interiors/model/leads_model.dart';
// import 'package:elegant_interiors/screens/enquiry_details_page/enquiry_details_screen.dart';
// import 'package:elegant_interiors/screens/leads/widgets/customer_card_widget.dart';
// import 'package:flutter/material.dart';


// class LeadsPage extends StatelessWidget {
//   LeadsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColorWhite,
//       appBar: AppBar(
//         title: Center(
//             child: Text(
//           "Leads Page",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//         )),
//       ),
//       body: FutureBuilder<LeadResponse>(
//         future: LeadController().fetchLeads(), // Fetch the leads data
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.leads.isEmpty) {
//             return Center(child: Text('No leads found.'));
//           }

//           final leads = snapshot.data!.leads; // Assuming 'leads' is the property in LeadResponse

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: leads.length,
//               itemBuilder: (context, index) {
//                 final lead = leads[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: CustomerCardWidget(
//                     name: lead.customerName, // Adjust according to your Lead model
//                     address: lead.place, // Adjust according to your Lead model
//                     phoneNumber: lead.customerPhone, // Adjust according to your Lead model
//                     onCallPressed: () {},
//                     onCardTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => EnquiryDetailsPage(
//                             name: lead.customerName, // Adjust according to your Lead model
//                             email: "newmali@gmail", // Add email field in your Lead model if needed
//                             phone: lead.customerPhone, // Adjust according to your Lead model
//                             address: lead.place, // Adjust according to your Lead model
//                             enquiryAbout: "Kitchen ", // Adjust according to your Lead model
//                             foundThrough: "googl", // Adjust according to your Lead model
//                             enquiryDate: DateTime.now(), // Set the date accordingly
//                             onEdit: () {
//                               // Handle edit action
//                             },
//                             onContact: () {
//                               // Handle contact action
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


// screens/leads_page.dart
import 'package:elegant_interiors/controller/leadcontroller.dart';
import 'package:elegant_interiors/screens/bottom_navigation/temp.dart';
import 'package:elegant_interiors/screens/leads/leads_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LeadsPage extends StatelessWidget {
  final LeadDataController leadController = Get.put(LeadDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       "Leads Page",
      //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      //     ),
      //   ),
      // ),
      
      body:
      
      // Obx(() {
      //   if (leadController.isLoading.value) {
      //     return Center(child: CircularProgressIndicator());
      //   } else if (leadController.leads.isEmpty) {
      //     return Center(child: Text('No leads found.'));
      //   } else {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListView.builder(
      //         itemCount: leadController.leads.length,
      //         itemBuilder: (context, index) {
      //           final lead = leadController.leads[index];
      //           return Padding(
      //             padding: const EdgeInsets.all(3.0),
      //             child: CustomerCardWidget(
      //               name: lead.customerName,
      //               address: lead.address,
      //               phoneNumber: lead.customerPhone,
      //               onCallPressed: () {
      //                 // Implement call functionality
      //               },
      //               onCardTap: () {
      //                 Navigator.of(context).push(
      //                   MaterialPageRoute(
      //                     builder: (context) => EnquiryDetailsPage(
      //                       name: lead.customerName,
      //                       email: lead.customerEmail,
      //                       phone: lead.customerPhone,
      //                       address: lead.address,
      //                       enquiryAbout: lead.enquiryAbout,
      //                       foundThrough: lead.foundThrough,
      //                       enquiryDate: DateTime.now(),
      //                       onEdit: () {
      //                         // Handle edit action
      //                       },
      //                       onContact: () {
      //                         // Handle contact action
      //                       },
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         },
      //       ),
      //     );
      //   }
      // }),
    
      LeadDataPage()
    );
  }
}
