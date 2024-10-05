import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final List<String> cardTitles = [
    'delivered',
    'Open Rate',
    'Click Rate',
    'Source',
  ];

  final List<String> cardSubtitles = [
    '50% ',
    '98%',
    '100% ',
    '78%',
  ];

  final List<String> cardAdditionalTexts = [
    '5%',
    '9%',
    '8%',
    '20%',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical:4 ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(cardTitles[0], cardSubtitles[0], cardAdditionalTexts[0]),
                    _buildCard(cardTitles[1], cardSubtitles[1], cardAdditionalTexts[1]),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(cardTitles[2], cardSubtitles[2], cardAdditionalTexts[2]),
                    _buildCard(cardTitles[3], cardSubtitles[3], cardAdditionalTexts[3]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String additionalText) {
    return Expanded(
      child: Card(
        elevation: 3,
        color: Colors.white, // Set card color to white
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                   SizedBox(width: 25), // Space between subtitle and additional text
              Text(
                "+$additionalText", // Smaller text below the subtitle
                style: TextStyle(
                  fontSize: 14, // Smaller font size
                  color: Colors.black54, // Lighter color for the smaller text
                ),
              ),
                ],
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
