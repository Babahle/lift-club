import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class CreateLiftView extends StatefulWidget {
  const CreateLiftView({super.key});

  @override
  State<CreateLiftView> createState() => _CreateLiftViewState();
}

class _CreateLiftViewState extends State<CreateLiftView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Create a Lift "));
  }
}