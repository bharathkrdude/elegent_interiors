class Lead {
  final String customerName;
  final String customerPhone;
  final String place;

  Lead({
    required this.customerName,
    required this.customerPhone,
    required this.place,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      place: json['place'],
    );
  }
}

class LeadResponse {
  final bool status;
  final List<Lead> leads;

  LeadResponse({
    required this.status,
    required this.leads,
  });

  factory LeadResponse.fromJson(Map<String, dynamic> json) {
    return LeadResponse(
      status: json['status'],
      leads: (json['leads'] as List)
          .map((leadJson) => Lead.fromJson(leadJson))
          .toList(),
    );
  }
}