import 'package:elegant_interiors/core/color.dart';
import 'package:elegant_interiors/screens/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  // Retrieve token from SharedPreferences
  Future<void> _loadToken() async {
    String? token = await _getToken();
    setState(() {
      _token = token;
    });
  }

  // Function to get the token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // Ensure the correct key is used
  }

  // Logout function to remove token from SharedPreferences and navigate to LoginScreen
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Ensure the correct key is used
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Trigger logout when button is pressed
          ),
        ],
      ),
      body:const Center(child: Text("app under construction!!"))
    );
  }
}




// class VacationRentalCard extends StatelessWidget {
//   final String title;
//   final double price;
//   final String location;
//   final int capacity;
//   final String description;
//   final double rating;
//   final int reviewCount;

//   const VacationRentalCard({
//     Key? key,
//     required this.title,
//     required this.price,
//     required this.location,
//     required this.capacity,
//     required this.description,
//     required this.rating,
//     required this.reviewCount,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 child: Image.asset(
//                   'assets/seaside_escape.jpg',
//                   fit: BoxFit.cover,
//                   height: 200,
//                   width: double.infinity,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     'Trending',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.headline6,
//                     ),
//                     Text(
//                       '\$$price/night',
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 18),
//                     Text('$rating ($reviewCount)'),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(Icons.location_on, size: 18),
//                     Text(location),
//                   ],
//                 ),
//                 SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.person, size: 18),
//                     Text('$capacity People'),
//                   ],
//                 ),
//                 SizedBox(height: 8),
               
//                 SizedBox(height: 4),
//                 Text(description),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     OutlinedButton(
//                       onPressed: () {},
//                       child: Text('Save for later'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text('Book'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }