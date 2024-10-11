import 'package:flutter/material.dart';

class Background extends StatelessWidget 
{
  const Background({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return
    Positioned.fill
    (
      child: Image.asset
      (
        'assets/background.jpg',
       fit: BoxFit.fill,
      ),
    );
  }
}