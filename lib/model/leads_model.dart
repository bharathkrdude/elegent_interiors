// models/lead_model.dart

class LeadModel {
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String address;
  final String enquiryAbout;
  final String foundThrough;

  LeadModel({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.address,
    required this.enquiryAbout,
    required this.foundThrough,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      address: json['address'],
      enquiryAbout: json['enquiry_about'],
      foundThrough: json['how_did_you_find_us'],
    );
  }
}
