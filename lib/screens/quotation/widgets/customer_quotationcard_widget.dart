import 'package:elegant_interiors/core/color.dart';
import 'package:flutter/material.dart';

class CustomerQuotationTile extends StatelessWidget {
  final String name;
  final String amount;
  final String commission;
  final VoidCallback onTap;
  final VoidCallback onCallPressed;

  const CustomerQuotationTile({
    Key? key,
    required this.name,
    required this.amount,
    required this.commission,
    required this.onTap,
    required this.onCallPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            _buildInfoText('Amount: ', amount, Colors.green),
                            SizedBox(width: 12),
                            _buildInfoText('Commission: ', commission, Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                  callButtonWidget(onCallPressed: onCallPressed),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value, Color color) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.blueGrey[600]),
        children: [
          TextSpan(text: label),
          TextSpan(
            text: value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class callButtonWidget extends StatelessWidget {
  const callButtonWidget({
    super.key,
    required this.onCallPressed,
  });

  final VoidCallback onCallPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      
      onPressed: onCallPressed,
      icon: Icon(Icons.call, size: 16,color: white,),
      label: Text('Call',style: TextStyle(
        color: white
      ),),
      style: ElevatedButton.styleFrom(
        backgroundColor: elegantRedColor,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
