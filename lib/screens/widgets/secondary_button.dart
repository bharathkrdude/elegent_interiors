import 'package:flutter/material.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Icon? icon;
  final Color? color; // Add color parameter with optional type

  const SecondaryButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.color, // Assign color as an optional argument
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color ?? const Color(0xFFDC2626), // Use the passed color or default to red
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Equal padding from both sides
            child: Row(
              children: [
                if (icon != null) icon!,
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
