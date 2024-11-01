// // controllers/lead_controller.dart
// import 'dart:convert';
// import 'package:elegant_interiors/model/lead_response.dart';
// import 'package:elegant_interiors/model/leads_model.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class LeadController extends GetxController {
//   var leads = <LeadModel>[].obs;
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchLeads();
//   }

//   Future<void> fetchLeads() async {
//     isLoading(true);
//     try {
//       var response = await http.get(
//         Uri.parse('https://elegantinteriors.in/demo/api/v1/get-enquiry'),
//       );

//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         LeadResponse leadResponse = LeadResponse.fromJson(jsonData);

//         if (leadResponse.status) {
//           leads.assignAll(leadResponse.leads);
//         } else {
//           print('Failed to fetch leads');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching leads: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:elegant_interiors/screens/bottom_navigation/temp.dart';
import 'package:get/get.dart';

class LeadDataController extends GetxController {
  var leads = <dynamic>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeads();
  }

  Future<void> fetchLeads() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      leads.value = await LeadsService.fetchLeads();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

