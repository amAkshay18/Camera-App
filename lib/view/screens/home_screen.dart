import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirstcamera/model/model.dart';
import 'package:myfirstcamera/view/screens/image_screen.dart';
import 'package:myfirstcamera/view_model/functions.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  File? firstImage;
  Future<void> picker() async {
    final imageSelected =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageSelected != null) {
      setState(() {
        firstImage = File(imageSelected.path);
        final image = ImageModel(imgpath: firstImage?.path ?? 'no-image');
        addImage(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllImages();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Images',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: ImageListNotifier,
          builder: (context, List<ImageModel> imageList, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  final data = imageList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenImage(images: data),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Image.file(
                        File(data.imgpath),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          picker();
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
