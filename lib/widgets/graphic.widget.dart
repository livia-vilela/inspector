import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graphic extends StatefulWidget 
{
  const Graphic({super.key});

  @override
  State<Graphic> createState() => _GraphicState();
}

var inlays = 100;
var right = 80;
var wrong = 20;
double percentage = 0;
double  wrongpc = getPercentage(inlays, wrong);
double  rightpc = getPercentage(inlays, right);

double getPercentage (var inlay, var analised)
{
  return percentage = ((100 * analised)/inlay);
}

class _GraphicState extends State<Graphic> 
{
  @override
  Widget build(BuildContext context) 
  {
    return 
      Center
      (
        child: PieChart
        (
          PieChartData
          (
            sections: getSections(),
            borderData: FlBorderData(show: false),
            sectionsSpace: 2,
            centerSpaceRadius: 0,
          )
        ),       
      );
  }
}

List <PieChartSectionData> getSections()
{
  return 
  [
    PieChartSectionData
    (
      color: Colors.red,
      value: getPercentage(inlays, wrong),
      title: 'Errados: $wrongpc%',
      radius: 220,
      titleStyle: const TextStyle
      (
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    PieChartSectionData
    (
      color: Colors.green,
      value: getPercentage(inlays, right),
      title: 'Certos: $rightpc%',
      radius: 220,
      titleStyle: const TextStyle
      (
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];
}