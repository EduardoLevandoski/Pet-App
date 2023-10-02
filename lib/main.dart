import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/Utils/util_cores.dart';
import 'package:pet_app/Views/principal.dart';
import 'package:pet_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet Application',
      debugShowCheckedModeBanner: false,
      theme: temaPrincipal,
      home: const Principal(),
    );
  }
}
