import 'package:flutter/material.dart';

class LeadsPage extends StatelessWidget {
   LeadsPage({super.key});
 final List<String> items = List.generate(10, (index) => 'Customer $index');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body:ListView.builder(
        itemCount: enquiries.length,
        itemBuilder: (context, index) {
          final enquiry = enquiries[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  enquiry.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      enquiry.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      enquiry.enquiry,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () {
                    // Add your call logic here
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

  final List<CustomerEnquiry> enquiries = [
    CustomerEnquiry(
      name: "John Doe",
      email: "johndoe@example.com",
      enquiry: "I need more information about your services.",
    ),
    CustomerEnquiry(
      name: "Jane Smith",
      email: "janesmith@example.com",
      enquiry: "Could you provide a quote for interior design?",
    ),
    // Add more customer data as needed
  ];



class CustomerEnquiry {
  final String name;
  final String email;
  final String enquiry;

  CustomerEnquiry({
    required this.name,
    required this.email,
    required this.enquiry,
  });
}

class EnquiryListPage extends StatelessWidget {
  final List<CustomerEnquiry> enquiries = [
    CustomerEnquiry(
      name: "John Doe",
      email: "johndoe@example.com",
      enquiry: "I need more information about your services.",
    ),
    CustomerEnquiry(
      name: "Jane Smith",
      email: "janesmith@example.com",
      enquiry: "Could you provide a quote for interior design?",
    ),
    // Add more customer data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Enquiries"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: enquiries.length,
        itemBuilder: (context, index) {
          final enquiry = enquiries[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  enquiry.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      enquiry.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      enquiry.enquiry,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () {
                    // Add your call logic here
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
