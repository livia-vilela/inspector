import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inspector/widgets/background.widget.dart';
import 'package:inspector/widgets/exitButton.widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final String databaseUrl = 'https://inspector-f0183-default-rtdb.firebaseio.com/class.json';
  late String classStatus = "Unknown";
  Timer? timer;

  var correctCount = 0;
  var errorCount = 0;
  var totalInlays = 0;

  Future<String> _loadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('inspector.jpg');
    final url = await imageRef.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    super.initState();
    _fetchClassData();
    _startPeriodicFetch();
  }

  @override
  void dispose() 
  {
    timer?.cancel(); 
    super.dispose();
  }

  void _startPeriodicFetch() 
  {
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) 
    {
      _fetchClassData(); 
    });
  }

  Future<void> _fetchClassData() async 
  {
    try 
    {
      final response = await http.get(Uri.parse(databaseUrl));
      print("Response: ${response.body}"); 

      if (response.statusCode == 200) 
      {
        final data = json.decode(response.body);
        print("Dados recebidos do Firebase: $data");
        if (data is String) 
        {
          classStatus = data;
        } 
        else 
        {
          classStatus = "Unknown";
        }

        if (classStatus == "semerro") {
          correctCount++;
        } else if (classStatus == "erro") {
          errorCount++;
        }

        totalInlays = correctCount + errorCount;

        setState(() 
        {
              
        });
        print('Valor de classStatus: $classStatus'); 
      } 
      else 
      {
        print("Falha ao carregar os dados: ${response.statusCode}");
      }
    } 
    catch (e) 
    {
      print("Erro: $e");
    }
  }

  Icon _getClassIcon(String className) {
    
    if (className == "semerro") {
      return const Icon(Icons.check_circle, size: 50, color: Colors.green);
    } else if (className == "erro") {
      return const Icon(Icons.cancel, size: 50, color: Colors.red);
    } else {
       print(className);
      return const Icon(Icons.help, size: 50, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 218, 133, 1.0),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Container(
              width: 900,
              height: 450,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(140, 82, 255, 1.0),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: FutureBuilder<String>(
                future: _loadImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); 
                  } else if (snapshot.hasError) {
                    return const Text("Error loading image"); 
                  } else if (snapshot.hasData) {
                    return Transform.rotate(
                      angle: 90 * pi / 180, 
                      child: Image.network(snapshot.data!, fit: BoxFit.cover)

                    );
                  } else {
                    return const Text("No image available");
                  }
                },
              ),
            ),
          ),
          ExitButton(
            correctCount: correctCount,
            errorCount: errorCount,
            totalInlays: totalInlays,),
          Container(
            height: 675,
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 300,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  _getClassIcon(classStatus),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
