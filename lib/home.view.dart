import 'package:flutter/material.dart';
import 'package:inspector/widgets/background.widget.dart';
import 'package:inspector/widgets/exitButton.widget.dart';
import 'package:inspector/widgets/showImage.widget.dart';


class HomeView extends StatefulWidget 
{
  const HomeView({super.key});
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> 
{
  bool isInlayOk = true;

  void _updateInlayStatus(bool status) 
  {
    setState(() 
    {
      isInlayOk = status;
    });
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: const Color.fromRGBO(255, 218, 133, 1.0),
      body: Stack
      (
        children: 
        [
          const Background(),
          Center
          (
            child: Container
            (
              width: 900,
              height: 500,
              decoration: 
              BoxDecoration
              (
                color:const Color.fromRGBO(140, 82, 255, 1.0),
                borderRadius: BorderRadius.circular(20)
              ),
              alignment: Alignment.center,

              child: SizedBox
              (
                width: 800,
                height: 400,
                child: ShowImage(onImageStatusChecked: _updateInlayStatus),
              ),
            ),
          ),


          const ExitButton(),

          Container
          (
            height: 675,
            alignment: Alignment.bottomLeft,
            child: SizedBox
            (
              width: 300,
              height: 50,
              child: 
              isInlayOk
                  ? const Icon(Icons.check_circle, size: 50, color: Colors.green)
                  : const Icon(Icons.cancel, size: 50, color: Colors.red),
            ),
          )
        ],
      ),
    );
  } 
}

