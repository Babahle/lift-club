import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/home.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:xid/xid.dart';

import '../custom_widgets/form_fields.dart';

class CreateLiftView extends StatefulWidget {
  const CreateLiftView({super.key});

  @override
  State<CreateLiftView> createState() => _CreateLiftViewState();
}

class _CreateLiftViewState extends State<CreateLiftView> {
  final TextEditingController _departureStreet = TextEditingController();

  final TextEditingController _departureTown = TextEditingController();

  final TextEditingController _destinationStreet = TextEditingController();

  final TextEditingController _destinationTown = TextEditingController();

  final TextEditingController _numberOfSeats = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  late DateTime? selectedDate;
  late TimeOfDay? time;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _departureStreet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Create A New Lift",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 30.0,
              ),
              _buildForm(),
            ],
          )),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CustomFormFields.buildLocationFormField(
                hint: "Enter The Departure Street Address",
                label: "Departure Street Address",
                controller: _departureStreet),
            const SizedBox(
              height: 20.0,
            ),
            CustomFormFields.buildLocationFormField(
                hint: "Enter The Departure Town / City",
                label: "Departure Town / City",
                controller: _departureTown),
            const SizedBox(
              height: 20.0,
            ),
            CustomFormFields.buildLocationFormField(
                hint: "Enter The Destination Street Address",
                label: "Destination Street Address",
                controller: _destinationStreet),
            const SizedBox(
              height: 20.0,
            ),
            CustomFormFields.buildLocationFormField(
                hint: "Enter The Destination Town / City",
                label: "Destination Town / City",
                controller: _destinationTown),
            const SizedBox(
              height: 20,
            ),
            CustomFormFields.buildNumberOfSeatsField(_numberOfSeats),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _dateController,
              onTap: (() async {
                await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 2))
                    .then((date) {
                  setState(() {
                    selectedDate = date;
                  });
                });

                await showTimePicker(
                        context: context, initialTime: TimeOfDay.now())
                    .then((value) {
                  setState(() {
                    time = value!;
                  });
                });

                if (selectedDate != null && time != null) {
                  setState(() {
                    DateTime submittedDate = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        time!.hour,
                        time!.minute);
                    selectedDate = submittedDate;
                    _dateController.text =
                        "${DateFormat.yMMMMEEEEd().format(selectedDate!)}, ${DateFormat.Hm().format(selectedDate!)}";
                  });
                }
              }),
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                  hintText: "Enter The Date & Time Of The Departure",
                  label: Text("Time Of Departure"),
                  prefixIcon: Icon(Icons.date_range)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a date";
                } else if (selectedDate!.isBefore(DateTime.now())) {
                  return "Date Cannot Be In The Past";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Consumer<AuthenticationService>(builder: (context, service, _) {
              return Consumer<LiftsViewModel>(
                  builder: (context, liftViewModel, _) {
                return _submitAction(service, liftViewModel, context);
              });
            })
          ],
        ));
  }

  ElevatedButton _submitAction(AuthenticationService service,
      LiftsViewModel liftViewModel, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Lift newLift = Lift(
                departureDateTime: selectedDate!,
                id: Xid.string(),
                ownerId: service.getUserId()!,
                ownerEmail: service.getUserEmail()!,
                departureStreet: _departureStreet.value.text,
                departureTown: _departureTown.value.text,
                destinationStreet: _destinationStreet.value.text,
                destinationTown: _destinationTown.value.text,
                numberOfPassengers: 0,
                seatsAvailable: int.parse(_numberOfSeats.value.text));

            liftViewModel.addLiftToDatabase(newLift);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Lifts")),
                (Route<dynamic> route) => false);
          }
        },
        child: const Text("Create"));
  }
}
