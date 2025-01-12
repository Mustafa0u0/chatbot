import 'package:aiu_chatbot/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AIU Chatbot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      getPages: AppRoutes.routes,
    );
  }
}

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.welcome);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/Logo.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
