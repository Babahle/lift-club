import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/pages/sign_in.dart';
import 'package:lifts_app/themes/main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lifts',
        theme: MainTheme.mainTheme,
        home:  SignInView());
  }
}
