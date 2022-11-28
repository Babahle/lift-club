import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class AllLiftsView extends StatefulWidget {
  const AllLiftsView({super.key});

  @override
  State<AllLiftsView> createState() => _AllLiftsViewState();
}

class _AllLiftsViewState extends State<AllLiftsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("All Available Lifts"));
  }
}