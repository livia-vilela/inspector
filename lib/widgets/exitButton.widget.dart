import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspector/graphic.view.dart';

class ExitButton extends StatelessWidget 
{
  const ExitButton({super.key});

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
              MaterialPageRoute(builder: (context) => const GraphicView())
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