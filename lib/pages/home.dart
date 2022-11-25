import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(builder: (context, fuelPriceModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Text('I need a lift!')
            ],
          ),
        ),
      );
    });
  }
}
