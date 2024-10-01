import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget 
{
  final Function(bool) onImageStatusChecked;
  const ShowImage({super.key, required this.onImageStatusChecked});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    _getLatestImageUrl();
  }

  Future<void> _getLatestImageUrl() async {
    // Replace 'your_directory' with the path where your images are stored
    String directoryPath = ''; 

    try {
      // List all items in the specified directory
      final ListResult result = await FirebaseStorage.instance
          .ref(directoryPath)
          .listAll();

      if (result.items.isNotEmpty) {
        List<Reference> files = result.items; // List of file references
        List<MapEntry<Reference, FullMetadata>> metadataList = [];

        // Fetch metadata for each file and store reference with its metadata
        for (Reference file in files) {
          FullMetadata metadata = await file.getMetadata();
          metadataList.add(MapEntry(file, metadata));
        }

        // Sort metadata by the last modified time
        metadataList.sort((a, b) => b.value.updated!.compareTo(a.value.updated!));

        // Get the latest file's download URL
        final String latestImageUrl = await metadataList.first.key!.getDownloadURL();

        setState(() {
          print(" Ultima Imagem");
          print(latestImageUrl);
          imageUrl = latestImageUrl; // Update the state with the latest URL
        });
      } else {
        print('No images found in the specified directory.');
      }
    } catch (e) {
      print('Error retrieving images: $e');
    }
  }

  Future<Map<String, dynamic>> _getImageInfo() async 
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;

    DocumentSnapshot snapshot = await firestore.collection('imagens').doc('minha-imagem').get();

    return snapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) 
  {
    return FutureBuilder<void>
    (
      future: _getLatestImageUrl(), 
      builder: (context, snapshot) 
      {
        if (snapshot.connectionState == ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator());
        } 
        
        else if (snapshot.hasError) 
        {
          return Center(child: Text('Erro ao carregar as informações da imagem'));
        } 
        
       /* else if (!snapshot.hasData || snapshot.data == null) 
        {
          return Center(child: Text('Resultado da verificação não encontrado'));
        }
        */
        else 
        {
          // Obtém a URL e a classe da imagem
          //String imageUrl = snapshot.data!['url']; 
          //String imageClass = snapshot.data!['classe']; 
          //bool isInlayOk = imageClass == 'sem erro';

          //widget.onImageStatusChecked(isInlayOk);

          return Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Image.network(imageUrl!),
              const SizedBox(height: 20),
            ],
          );
        }
      },
    );
  }
}