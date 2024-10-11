import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration getTextFieldDecoration (String label)
{
    return
    InputDecoration
    (
      labelText: label,
      labelStyle: 
      GoogleFonts.aleo
      (
        textStyle: 
        const TextStyle
        (
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(140, 82, 255, 1.0) 
        )
      ),
      fillColor: const Color.fromARGB(255, 255, 241, 221),
      filled: true,
      border: OutlineInputBorder
      (
        borderRadius: BorderRadius.circular(50)
      ),
    );
}