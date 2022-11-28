import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class BookedLiftsView extends StatefulWidget {
  const BookedLiftsView({super.key});

  @override
  State<BookedLiftsView> createState() => _BookedLiftsViewState();
}

class _BookedLiftsViewState extends State<BookedLiftsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Booked Lifts"));
  }
}