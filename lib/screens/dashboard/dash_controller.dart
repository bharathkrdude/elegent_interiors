import 'package:elegant_interiors/model/dashboard_model.dart';
import 'package:elegant_interiors/services/quotaion_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// class DashboardController extends GetxController {
//   var cardSubtitles = [
//     '80', // Placeholder while data is fetched
//     '70',
//     '92',
//     '78',
//   ].obs;

//   final List<String> cardAdditionalTexts = [
//     '5%',
//     '9%',
//     '8%',
//     '20%',
//   ];
   
//   String bearerToken = ''; // Token will be fetched dynamically

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     final url = 'https://elegantinteriors.in/api/v1/get-dashboard';

//     try {
//       // Get token from SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bearerToken = prefs.getString('token') ?? '';

//       if (bearerToken.isNotEmpty) {
//         final response = await http.get(
//           Uri.parse(url),
//           headers: {
//             'Authorization': 'Bearer $bearerToken',
//           },
//         );

//         if (response.statusCode == 200) {
//           final jsonResponse = json.decode(response.body);
//           if (jsonResponse['status'] == true) {
//             final data = jsonResponse['data'];

//             cardSubtitles[0] = '${data['no_of_leads']}';
//             cardSubtitles[1] = '${data['no_of_customers']}';
//             cardSubtitles[2] = '${data['quotation_amount']}';
//             cardSubtitles[3] = '${data['commission_amount']}';
//           }
//         } else {
//           print('Failed to fetch dashboard data: ${response.statusCode}');
//         }
//       } else {
//         print('Bearer token is not available');
//       }
//     } catch (error) {
//       print('Error fetching dashboard data: $error');
//     }
//   }
// }
// dashboard_controller.dart
import 'package:get/get.dart';


class DashboardController extends GetxController {
  var isLoading = true.obs;
  var dashboardModel = DashboardModel(status: false, message: '', data: DashboardData(noOfLeads: 0, noOfCustomers: 0, quotationAmount: 0, commissionAmount: 0)).obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchDashboardData();
    super.onInit();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading(true);
      var response = await QuotationService.fetchDashboardData();
      dashboardModel.value = DashboardModel.fromJson(response);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
