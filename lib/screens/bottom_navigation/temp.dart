// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';

// // // Model
// // class Leadr {
// //   final String customerName;
// //   final String customerEmail;
// //   // Add other fields as needed

// //   Leadr({required this.customerName, required this.customerEmail});

// //   factory Leadr.fromJson(Map<String, dynamic> json) {
// //     return Leadr(
// //       customerName: json['customer_name'],
// //       customerEmail: json['customer_email'],
// //     );
// //   }
// // }

// // // Controller
// // class LeaderController extends GetxController {
// //   var leads = <Leadr>[].obs;
// //   var isLoading = false.obs;

// //   Future<void> fetchLeads() async {
// //     isLoading(true);
// //     try {
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       String? token = prefs.getString('authToken'); // Retrieve token from SharedPreferences

// //       if (token != null) {
// //         var response = await http.get(
// //           Uri.parse('http://cafarde.in/api/leads-list'),
// //           headers: {
// //             'Authorization': 'Bearer $token', // Use the token in the headers
// //           },
// //         );

// //         if (response.statusCode == 200) {
// //           var jsonData = json.decode(response.body);
// //           leads.value = (jsonData['leads'] as List)
// //               .map((leadJson) => Leadr.fromJson(leadJson))
// //               .toList();
// //         } else {
// //           throw Exception('Failed to load leads');
// //         }
// //       } else {
// //         throw Exception('No token found');
// //       }
// //     } catch (e) {
// //       print('Error fetching leads: $e');
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }


// // // View
// // class LeadsView extends StatelessWidget {
// //   final LeaderController controller = Get.put(LeaderController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Leads')),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return Center(child: CircularProgressIndicator());
// //         } else {
// //           return ListView.builder(
// //             itemCount: controller.leads.length,
// //             itemBuilder: (context, index) {
// //               var lead = controller.leads[index];
// //               return ListTile(
// //                 title: Text(lead.customerName),
// //                 subtitle: Text(lead.customerEmail),
// //               );
// //             },
// //           );
// //         }
// //       }),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: controller.fetchLeads,
// //         child: Icon(Icons.refresh),
// //       ),
// //     );
// //   }
// // }






// import 'package:elegant_interiors/controller/leadcontroller.dart';
// import 'package:elegant_interiors/core/color.dart';
// import 'package:elegant_interiors/screens/enquiry_details_page/enquiry_details_screen.dart';
// import 'package:elegant_interiors/screens/leads/widgets/customer_card_widget.dart';
// import 'package:elegant_interiors/screens/widgets/custom_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// import 'package:url_launcher/url_launcher.dart';


// class AuthService {
//   static const String _tokenKey = 'auth_token';
//   static const String _baseUrl = 'https://elegantinteriors.in/demo/api/v1';

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<bool> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/login'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['token'] != null) {
//           await saveToken(data['token']);
//           return true;
//         }
//       }
//     } catch (e) {
//       print('Error during login: $e');
//     }
//     return false;
//   }

//   static Future<bool> refreshToken() async {
//     try {
//       final currentToken = await getToken();
//       final response = await http.post(
//         Uri.parse('$_baseUrl/refresh-token'),
//         headers: {'Authorization': 'Bearer $currentToken'},
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['token'] != null) {
//           await saveToken(data['token']);
//           return true;
//         }
//       }
//     } catch (e) {
//       print('Error refreshing token: $e');
//     }
//     return false;
//   }
// }


// class LeadsService {
//   static Future<List<dynamic>> fetchLeads() async {
//     String? token = await AuthService.getToken();
//     if (token == null) {
//       throw Exception('No token available');
//     }
//     final url = Uri.parse('${AuthService._baseUrl}/get-enquiry');
//     final response = await _authenticatedRequest(url, token);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print('API Response: $data'); // This line is helpful for debugging
//       if (data is Map<String, dynamic> && data.containsKey('enquiries')) {
//         return data['enquiries'];
//       } else {
//         throw Exception('Unexpected data structure: ${data.keys.join(', ')}');
//       }
//     } else {
//       throw Exception('Failed to load leads: ${response.reasonPhrase}');
//     }
//   }

//   static Future<http.Response> _authenticatedRequest(Uri url, String token) async {
//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Accept': 'application/json',
//     };
//     http.Response response = await http.get(url, headers: headers);
//     if (response.statusCode == 401) {
//       bool refreshed = await AuthService.refreshToken();
//       if (refreshed) {
//         String? newToken = await AuthService.getToken();
//         if (newToken != null) {
//           headers['Authorization'] = 'Bearer $newToken';
//           response = await http.get(url, headers: headers);
//         }
//       }
//     }
//     return response;
//   }
// }

// class LeadDataPage extends StatelessWidget {
//   final LeadDataController controller = Get.put(LeadDataController());
//   DateTime? fromDate;
//   DateTime? toDate;

//   LeadDataPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchLeads(); // Ensure leads are fetched when the page loads
//     return Scaffold(
//       appBar:CustomAppBar(title: 'Leads page',actions: [ IconButton(
//             icon: Icon(Icons.filter_list,color: white,),
//             onPressed: () => _showDateRangePicker(context),
//           ),],),
      
//       body: Obx(
//         () {
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           } else if (controller.errorMessage.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage.value));
//           } else {
//             final filteredLeads = _filterLeads(controller.leads);
//             return Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: ListView.builder(
//                 itemCount: filteredLeads.length,
//                 itemBuilder: (context, index) {
//                   final lead = filteredLeads[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 8, right: 8),
//                     child: CustomerCardWidget(
//                       name: lead['first_name'] ?? 'No name',
//                       address: lead['address'] ?? 'No address',
//                       phoneNumber: lead['phone'] ?? 'No phone',
//                       onCallPressed: () {
//                         makeCall(lead['phone']);
//                       },
//                       onCardTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => EnquiryDetailsPage(
//                               name: lead['first_name'] ?? 'No name',
//                               email: lead['email'] ?? 'No email',
//                               phone: lead['phone'] ?? 'No phone',
//                               address: lead['address'] ?? 'No address',
//                               enquiryAbout: lead['enquiry'] ?? 'N/A',
//                               foundThrough: lead['how_did_you_find_us'] ?? 'N/A',
//                               enquiryDate: lead['created_at'],
//                               onEdit: () {
//                                 // Handle edit action
//                               },
//                               onContact: () {
//                                 makeCall(lead['phone']);
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   void makeCall(String phoneNumber) async {
//     try {
//       await FlutterPhoneDirectCaller.callNumber(phoneNumber);
//     } catch (e) {
//       print('Error making call: $e');
//     }
//   }

//   void _showDateRangePicker(BuildContext context) async {
//     DateTimeRange? selectedDateRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       initialDateRange: fromDate != null && toDate != null
//           ? DateTimeRange(start: fromDate!, end: toDate!)
//           : null,
//     );

//     if (selectedDateRange != null) {
//       fromDate = selectedDateRange.start;
//       toDate = selectedDateRange.end;
//       // Optionally fetch leads again if necessary
//       controller.fetchLeads();
//     }
//   }

//   List<dynamic> _filterLeads(List<dynamic> leads) {
//     if (fromDate == null || toDate == null) {
//       return leads; // Return all leads if no date range is selected
//     }

//     // Filter leads based on enquiryDate
//     return leads.where((lead) {
//       DateTime enquiryDate = DateTime.parse(lead['created_at']);
//       return enquiryDate.isAfter(fromDate!.subtract(Duration(days: 1))) && enquiryDate.isBefore(toDate!.add(Duration(days: 1)));
//     }).toList();
//   }
// }
