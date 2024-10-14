import 'package:elegant_interiors/services/quotaion_service.dart';
import 'package:get/get.dart';

class QuotationController extends GetxController {
  var quotations = <dynamic>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotations();
  }

  Future<void> fetchQuotations() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      quotations.value = await QuotationService.fetchQuotations();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
