import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
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
  final String databaseUrl = 'https://inspector-f0183-default-rtdb.firebaseio.com/';
  late DatabaseReference _databaseRef;

  late String classStatus; // Renamed for clarity

  Future<String> _loadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('inspector.jpg');
    final url = await imageRef.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref("class"); // Reference to the "class" node
    _fetchClassData(); // Fetch class data
  }

  // Fetches the class data and updates the UI state
  Future<void> _fetchClassData() async {
    try {
      final response = await http.get(Uri.parse('$databaseUrl/class.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);//ok
        setState(() {
          classStatus = data ?? "Unknown"; // Handle null case
        });
        print('valor de class status: $classStatus');//ok
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Returns an icon based on the classStatus value
  Icon _getClassIcon(String className) {
    
    if (className == "semerro") {
      return const Icon(Icons.check_circle, size: 50, color: Colors.green);
    } else if (className == "erro") {
      return const Icon(Icons.cancel, size: 50, color: Colors.red);
    } else {
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
                    return const CircularProgressIndicator(); // Loading indicator
                  } else if (snapshot.hasError) {
                    return const Text("Error loading image"); // Error message
                  } else if (snapshot.hasData) {
                    return Transform.rotate(
                      angle: 90 * pi / 180, 
                      child: SizedBox(
                        width: 400,
                        child: Image.network(snapshot.data!, fit: BoxFit.cover)
                      )
                    );
                  } else {
                    return const Text("No image available");
                  }
                },
              ),
            ),
          ),
          const ExitButton(),
          Container(
            height: 675,
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 300,
              height: 50,
              child: StreamBuilder
              (
                stream: _databaseRef.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) 
                {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.snapshot.value;

                    // Log data for debugging
                    print('Data from Firebase: $data');
                    
                    if (data is Map) {
                      // Assuming your classStatus is a field in the Map
                      classStatus = data['className'] ?? "Unknown"; // Adjust based on your structure
                    } else {
                      classStatus = data.toString(); // Fallback
                    }

                    print('Class Status: $classStatus'); // Debugging output

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _getClassIcon(classStatus), // Pass the updated classStatus
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error loading class");
                  } else {
                    return const CircularProgressIndicator(); // Loading indicator
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
