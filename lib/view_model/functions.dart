import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/model.dart';

// ignore: non_constant_identifier_names
ValueNotifier<List<ImageModel>> ImageListNotifier = ValueNotifier([]);

Future<void> addImage(ImageModel value) async {
  // print(StudentListNotifier.value);
  // ignore: non_constant_identifier_names
  final DB = await Hive.openBox<ImageModel>('box');
  await DB.add(value);
  ImageListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  ImageListNotifier.notifyListeners();
}

Future<void> getAllImages() async {
  // ignore: non_constant_identifier_names
  final DB = await Hive.openBox<ImageModel>('box');
  ImageListNotifier.value.clear();
  ImageListNotifier.value.addAll(DB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  ImageListNotifier.notifyListeners();
}

Future<void> delete(int id) async {
  // ignore: non_constant_identifier_names
  final DB = await Hive.openBox<ImageModel>('box');
  await DB.delete(id);
  getAllImages();
}
