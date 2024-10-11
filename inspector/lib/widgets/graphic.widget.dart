import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graphic extends StatelessWidget {
  final double correctPercentage;
  final double errorPercentage;

  const Graphic({
    super.key,
    required this.correctPercentage,
    required this.errorPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Gráfico de pizza
          SizedBox(
            width: 500,
            height: 500,
            child: PieChart(
              PieChartData(
                sections: _buildPieChartSections(), // Constrói as seções
                centerSpaceRadius:0, // Espaço central vazio
                sectionsSpace: 2, // Espaço entre as fatias
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Função que constrói as seções do gráfico de pizza
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green, // Cor para os acertos
        value: correctPercentage,
        title: '${correctPercentage.toStringAsFixed(1)}%', // Texto na fatia
        radius: 220,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red, // Cor para os erros
        value: errorPercentage,
        title: '${errorPercentage.toStringAsFixed(1)}%', // Texto na fatia
        radius: 220,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
