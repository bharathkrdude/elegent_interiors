// models/lead_response.dart
import 'package:elegant_interiors/model/leads_model.dart';


class LeadResponse {
  final bool status;
  final List<LeadModel> leads;

  LeadResponse({required this.status, required this.leads});

  factory LeadResponse.fromJson(Map<String, dynamic> json) {
    return LeadResponse(
      status: json['status'],
      leads: (json['leads'] as List)
          .map((lead) => LeadModel.fromJson(lead))
          .toList(),
    );
  }
}
