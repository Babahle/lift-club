import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => LiftsViewModel(),
          child: const MyHomePage(title: 'Lifts'),
      )
    );
  }
}
