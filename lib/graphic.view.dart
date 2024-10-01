import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspector/login.view.dart';
import 'package:inspector/widgets/background.widget.dart';
import 'package:inspector/widgets/graphic.widget.dart';

class GraphicView extends StatefulWidget 
{
  const GraphicView({super.key});

  @override
  State<GraphicView> createState() => _GraphicViewState();
}

class _GraphicViewState extends State<GraphicView> 
{
  var inlays = 0;
  @override
  Widget build(BuildContext context) 
  {
    return
    Scaffold
    (
      backgroundColor: const Color.fromRGBO(255, 218, 133, 1.0),
      body: Stack
      (
        children: 
        [
          const Background(),
          const Graphic(),

          Container
          (
            height: 800,
            alignment: Alignment.centerRight,
            child: SizedBox
            (
              width: 250,
              child: Text
              (
                'Inlays Analisados: $inlays',
                style: GoogleFonts.aleo
                (
                  textStyle: 
                  const TextStyle
                  (
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
                )
              ),
            ),
          ),
          Center
          (
            child: Container
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
                      MaterialPageRoute(builder: (context) => const LoginView())
                    );
                  },
                  style: ElevatedButton.styleFrom
                  (
                    backgroundColor: const Color.fromRGBO(255, 130, 0, 1),
                  ),  
                  child: Text
                  (
                    'Encerrar Sessão',
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
                  )
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}