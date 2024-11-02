// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// // Model
// class Leadr {
//   final String customerName;
//   final String customerEmail;
//   // Add other fields as needed

//   Leadr({required this.customerName, required this.customerEmail});

//   factory Leadr.fromJson(Map<String, dynamic> json) {
//     return Leadr(
//       customerName: json['customer_name'],
//       customerEmail: json['customer_email'],
//     );
//   }
// }

// // Controller
// class LeaderController extends GetxController {
//   var leads = <Leadr>[].obs;
//   var isLoading = false.obs;

//   Future<void> fetchLeads() async {
//     isLoading(true);
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('authToken'); // Retrieve token from SharedPreferences

//       if (token != null) {
//         var response = await http.get(
//           Uri.parse('http://cafarde.in/api/leads-list'),
//           headers: {
//             'Authorization': 'Bearer $token', // Use the token in the headers
//           },
//         );

//         if (response.statusCode == 200) {
//           var jsonData = json.decode(response.body);
//           leads.value = (jsonData['leads'] as List)
//               .map((leadJson) => Leadr.fromJson(leadJson))
//               .toList();
//         } else {
//           throw Exception('Failed to load leads');
//         }
//       } else {
//         throw Exception('No token found');
//       }
//     } catch (e) {
//       print('Error fetching leads: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// // View
// class LeadsView extends StatelessWidget {
//   final LeaderController controller = Get.put(LeaderController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Leads')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: controller.leads.length,
//             itemBuilder: (context, index) {
//               var lead = controller.leads[index];
//               return ListTile(
//                 title: Text(lead.customerName),
//                 subtitle: Text(lead.customerEmail),
//               );
//             },
//           );
//         }
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: controller.fetchLeads,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }



import 'package:elegant_interiors/controller/leadcontroller.dart';
import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/enquiry_details_page/enquiry_details_screen.dart';
import 'package:elegant_interiors/screens/leads/widgets/customer_card_widget.dart';
import 'package:elegant_interiors/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _baseUrl = 'https://elegantinteriors.in/demo/api/v1';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['token'] != null) {
          await saveToken(data['token']);
          return true;
        }
      }
    } catch (e) {
      print('Error during login: $e');
    }
    return false;
  }

  static Future<bool> refreshToken() async {
    try {
      final currentToken = await getToken();
      final response = await http.post(
        Uri.parse('$_baseUrl/refresh-token'),
        headers: {'Authorization': 'Bearer $currentToken'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['token'] != null) {
          await saveToken(data['token']);
          return true;
        }
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
    return false;
  }
}

class LeadsService {
  static Future<List<dynamic>> fetchLeads(
      {int page = 1, int limit = 20}) async {
    String? token = await AuthService.getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    final url = Uri.parse(
        '${AuthService._baseUrl}/get-enquiry?page=$page&limit=$limit');
    final response = await _authenticatedRequest(url, token);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // This line is helpful for debugging
      if (data is Map<String, dynamic> && data.containsKey('enquiries')) {
        return data['enquiries'];
      } else {
        throw Exception('Unexpected data structure: ${data.keys.join(', ')}');
      }
    } else {
      throw Exception('Failed to load leads: ${response.reasonPhrase}');
    }
  }

  static Future<http.Response> _authenticatedRequest(
      Uri url, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      bool refreshed = await AuthService.refreshToken();
      if (refreshed) {
        String? newToken = await AuthService.getToken();
        if (newToken != null) {
          headers['Authorization'] = 'Bearer $newToken';
          response = await http.get(url, headers: headers);
        }
      }
    }
    return response;
  }
}


class LeadDataPage extends StatelessWidget {
  final LeadDataController controller = Get.put(LeadDataController());

  LeadDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Leads',
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: white),
            onPressed: () => _showCustomDateRangePicker(context),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value && controller.displayedLeads.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else {
            return ListView.builder(
              itemCount: controller.displayedLeads.length,
              itemBuilder: (context, index) {
                final lead = controller.displayedLeads[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: CustomerCardWidget(
                    name: lead['first_name'] ?? 'No name',
                    address: lead['address'] ?? 'No address',
                    phoneNumber: lead['phone'] ?? 'No phone',
                    onCallPressed: () {
                      makeCall(lead['phone']);
                    },
                    onCardTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EnquiryDetailsPage(
                            name: lead['first_name'] ?? 'No name',
                            email: lead['email'] ?? 'No email',
                            phone: lead['phone'] ?? 'No phone',
                            address: lead['address'] ?? 'No address',
                            enquiryAbout: lead['enquiry'] ?? 'N/A',
                            foundThrough: lead['how_did_you_find_us'] ?? 'N/A',
                            enquiryDate: lead['created_at'],
                            onEdit: () {
                              // Handle edit action
                            },
                            onContact: () {
                              makeCall(lead['phone']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void makeCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      print('Error making call: $e');
    }
  }// Make sure to import intl package
Future<void> _showCustomDateRangePicker(BuildContext context) async {
  DateTimeRange? selectedDateRange;

  // Determine the first available date from the lead data
  DateTime? firstAvailableDate;
  if (controller.allLeads.isNotEmpty) {
    // Assuming leads have a 'created_at' field with valid dates
    firstAvailableDate = controller.allLeads
        .map((lead) => DateTime.parse(lead['created_at']))
        .reduce((a, b) => a.isBefore(b) ? a : b);
  }

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: white,
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Select Date Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: firstAvailableDate ?? DateTime(2000), // Earliest date from leads
                        lastDate: DateTime.now(), // Today's date to prevent future selection
                        initialDateRange: selectedDateRange,
                      );
                      if (picked != null) {
                        setState(() => selectedDateRange = picked);
                      }
                    },
                    icon: const Icon(Icons.date_range, color: Colors.white),
                    label: Text(
                      selectedDateRange != null
                          ?  "${DateFormat('yyyy-MM-dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy-MM-dd').format(selectedDateRange!.end)}"
                          : "Select Date Range",
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: elegantRedColor,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  selectedDateRange != null?
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDateRange = null;
                        controller.fromDate = null;
                        controller.toDate = null;
                      });
                    },
                    child: const Text(
                      "Clear Selection",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ):SizedBox(),
                ],
              ),
            );
          },
        ),
        actionsPadding: const EdgeInsets.only(bottom: 12, right: 12),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
             ElevatedButton(
  onPressed: () {
    // Call the resetFilters method in the controller
    controller.resetFilters(); // Reset filters and fetch all leads
    Navigator.of(context).pop();
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Change color as needed
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: const Text(
    "Reset Filters",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
          ElevatedButton(
            onPressed: () {
              if (selectedDateRange != null) {
                controller.fromDate = selectedDateRange!.start;
                controller.toDate = selectedDateRange!.end;
                controller.updateDisplayedLeads(); // Update leads based on date range
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: elegantRedColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

}