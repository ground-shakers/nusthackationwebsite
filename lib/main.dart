import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:nusthackationwebsite/pages/chatbot.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';
//import 'package:nusthackationwebsite/pages/dashboard.dart';
//import 'package:nusthackationwebsite/pages/landingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medical Expert System for Malaria & Typhoid Fever',
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: const ChatbotPage(),
          restorationScopeId: 'app',
        );
      },
    );
  }
}
