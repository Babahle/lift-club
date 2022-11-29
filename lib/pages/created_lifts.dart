import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class CreatedLiftsView extends StatefulWidget {
  const CreatedLiftsView({super.key});

  @override
  State<CreatedLiftsView> createState() => _CreatedLiftsViewState();
}

class _CreatedLiftsViewState extends State<CreatedLiftsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Created Lifts"));
  }
}
