import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myfirstcamera/model/model.dart';
import 'package:myfirstcamera/view/screens/home_screen.dart';
import 'package:myfirstcamera/view_model/functions.dart';

// ignore: must_be_immutable
class ScreenImage extends StatelessWidget {
  ImageModel images;
  ScreenImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Do yo want to Delete'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('DELETE'),
                          onPressed: () {
                            delete(images.key);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScreenHome(),
                                ));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(images.imgpath),
              fit: BoxFit.cover,
              width: 300,
              height: 300,
            )
          ],
        ),
      )),
    );
  }
}
