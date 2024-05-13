import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myfirstcamera/model/model.dart';
import 'package:myfirstcamera/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ImageModelAdapter().typeId)) {
    Hive.registerAdapter(
      ImageModelAdapter(),
    );
    runApp(
      const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera App',
      theme:
          ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.light),
      home: const ScreenSplash(),
    );
  }
}
