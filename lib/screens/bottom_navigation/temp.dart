import 'package:elegant_interiors/controller/leadcontroller.dart';
import 'package:elegant_interiors/model/leads_model.dart';
import 'package:flutter/material.dart';

class LeadListScreen extends StatefulWidget {
  @override
  _LeadListScreenState createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  final LeadController _leadController = LeadController();
  late Future<LeadResponse> _leadsFuture;

  @override
  void initState() {
    super.initState();
    _leadsFuture = _leadController.fetchLeads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leads')),
      body: FutureBuilder<LeadResponse>(
        future: _leadsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.leads.length,
              itemBuilder: (context, index) {
                final lead = snapshot.data!.leads[index];
                return ListTile(
                  title: Text(lead.customerName),
                  subtitle: Text(lead.place),
                  trailing: Text(lead.customerPhone),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}