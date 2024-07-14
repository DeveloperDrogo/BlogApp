import 'package:clean/core/theme/theme.dart';
import 'package:clean/features/auth/presentation/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Apptheme.darkModeTheme,
      home: const SignupPage()
    );
  }
}

