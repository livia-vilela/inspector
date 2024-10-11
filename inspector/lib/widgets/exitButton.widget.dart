import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspector/graphic.view.dart';

class ExitButton extends StatelessWidget 
{
   final int correctCount;
  final int errorCount;
  final int totalInlays;

  const ExitButton({
    super.key,
    required this.correctCount,
    required this.errorCount,
    required this.totalInlays,
  });

  @override
  Widget build(BuildContext context) 
  {
    return 
    Container
    (
      height: 675,
      alignment: Alignment.bottomCenter,
      child: SizedBox
      (
        width: 300,
        height: 50,
        child: ElevatedButton
        (
          onPressed: ()
          {
            Navigator.push
            (
              context,
              MaterialPageRoute(builder: (context) => GraphicView
              (
                correctCount: correctCount,
                errorCount: errorCount,
                totalInlays: totalInlays,
              ))
            );
          },
          style: ElevatedButton.styleFrom
          (
            backgroundColor: const Color.fromRGBO(255, 130, 0, 1),
          ), 
          child: Text
          (
           'Ver Estatísticas',
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