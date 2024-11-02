import 'package:elegant_interiors/screens/leads/leads_data_screen.dart';
import 'package:get/get.dart';

class LeadDataController extends GetxController {
  var allLeads = <dynamic>[].obs; // Store all fetched leads
  var displayedLeads = <dynamic>[].obs; // Store currently displayed leads
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void onInit() {
    super.onInit();
    fetchLeads(); // Fetch all leads initially
  }

  Future<void> fetchLeads() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      allLeads.value = await LeadsService.fetchLeads(); // Fetch all leads from API
      updateDisplayedLeads(); // Update displayed leads
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateDisplayedLeads() {
    // Filter leads based on date range
    displayedLeads.value = filterLeads(allLeads);
  }
List<dynamic> filterLeads(List<dynamic> leads) {
  if (fromDate == null || toDate == null) {
    return leads; // Return all leads if no date range is selected
  }

  // Filter leads based on created_at date
  return leads.where((lead) {
    DateTime enquiryDate = DateTime.parse(lead['created_at']);
    return enquiryDate.isAfter(fromDate!.subtract(Duration(days: 1))) && 
           enquiryDate.isBefore(toDate!.add(Duration(days: 1)));
  }).toList();
}


  // New method to reset filters
  void resetFilters() {
    fromDate = null; // Clear fromDate
    toDate = null;   // Clear toDate
    fetchLeads();    // Fetch all leads again
  }
}
