// dashboard_model.dart
class DashboardModel {
  final bool status;
  final String message;
  final DashboardData data;

  DashboardModel({required this.status, required this.message, required this.data});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json['status'],
      message: json['message'],
      data: DashboardData.fromJson(json['data']),
    );
  }
}

class DashboardData {
  final int noOfLeads;
  final int noOfCustomers;
  final int quotationAmount;
  final int commissionAmount;

  DashboardData({
    required this.noOfLeads,
    required this.noOfCustomers,
    required this.quotationAmount,
    required this.commissionAmount,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      noOfLeads: json['no_of_leads'],
      noOfCustomers: json['no_of_customers'],
      quotationAmount: json['quotation_amount'],
      commissionAmount: json['commission_amount'],
    );
  }
}
