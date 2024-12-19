import 'package:flutter/material.dart';

// Creating a Stateless Widget for buttons
class MyButton extends StatelessWidget {
  // Declaring variables
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback? buttontapped;
  final double borderRadius; // New optional border radius
  final bool withShadow; // Option to include shadow

  // Constructor with optional parameters
  MyButton({
    required this.color,
    required this.textColor,
    required this.buttonText,
    this.buttontapped,
    this.borderRadius = 10.0, // Default border radius
    this.withShadow = false,  // Default shadow option
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: withShadow
                  ? [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ]
                  : [],
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
