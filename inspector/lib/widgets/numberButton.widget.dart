import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NumberButton extends StatelessWidget
{
  final String number;
  final VoidCallback onPressed;

  const NumberButton
  (
    {
      super.key, 
      required this.number, 
      required this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom
          (
            backgroundColor: const Color.fromRGBO(140, 82, 255, 1.0),
          ),
          child: Text
          (
            number,
            style: GoogleFonts.aleo
            (
              textStyle: 
                const TextStyle
                (
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(235, 225, 225, 1) 
                )
            ),
          ),
        ),
      ),
    );
  }
}