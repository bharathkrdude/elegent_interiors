import 'package:elegant_interiors/screens/dashboard/dashboard.dart';
import 'package:elegant_interiors/screens/enquiry_form.dart';
import 'package:elegant_interiors/screens/leads/screen_leads.dart';
import 'package:elegant_interiors/screens/quotation/quotation_screen.dart';
import 'package:elegant_interiors/screens/temp.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    EnquiryForm(),
    TempPage(),
    LeadsPage(),
    QuotationScreen(),
    Dashboard()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
        
          iconSize: 24,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 30, color: Colors.red),
          unselectedIconTheme: const IconThemeData(size: 25),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback_outlined),
              label: 'Feedback',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check_circle_rounded,size:36,),
              label: 'Leads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined),
              label: 'Quotaion',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined),
              label: 'Dashboard',
            ),
          ],
        ),
      ),
    );
  }
}
