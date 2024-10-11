import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspector/login.view.dart';
import 'package:inspector/widgets/background.widget.dart';
import 'package:inspector/widgets/graphic.widget.dart'; // Supondo que você tem um widget gráfico

class GraphicView extends StatefulWidget {
  final int correctCount; // Contagem de acertos (semerro)
  final int errorCount;   // Contagem de erros (erro)
  final int totalInlays;  // Total de inlays analisados

  const GraphicView({
    super.key,
    required this.correctCount,
    required this.errorCount,
    required this.totalInlays,
  });

  @override
  State<GraphicView> createState() => _GraphicViewState();
}

class _GraphicViewState extends State<GraphicView> {
  @override
  Widget build(BuildContext context) {
    // Calcular porcentagens de acertos e erros
    double correctPercentage = widget.totalInlays > 0
        ? (widget.correctCount / widget.totalInlays) * 100
        : 0.0;
    double errorPercentage = widget.totalInlays > 0
        ? (widget.errorCount / widget.totalInlays) * 100
        : 0.0;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 218, 133, 1.0),
      body: Stack(
        children: [
          const Background(), // Background da tela

          // Aqui entra o widget gráfico com os dados
          Graphic(
            correctPercentage: correctPercentage, // Porcentagem de acertos
            errorPercentage: errorPercentage,     // Porcentagem de erros
          ),

          // Exibe o total de inlays analisados no canto direito
          Container(
            height: 800,
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 250,
              child: Text(
                'Inlays Analisados: ${widget.totalInlays}',
                style: GoogleFonts.aleo(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Botão de encerrar sessão
          Center(
            child: Container(
              height: 675,
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 130, 0, 1),
                  ),
                  child: Text(
                    'Encerrar Sessão',
                    style: GoogleFonts.aleo(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(235, 225, 225, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
