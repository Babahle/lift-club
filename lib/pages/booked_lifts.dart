import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:lifts_app/custom_widgets/lift_card.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/bookings_view_model.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/services/authentication.dart';
import 'package:provider/provider.dart';

class BookedLiftsView extends StatefulWidget {
  const BookedLiftsView({super.key});

  @override
  State<BookedLiftsView> createState() => _BookedLiftsViewState();
}

class _BookedLiftsViewState extends State<BookedLiftsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthenticationService>(context).getUserId()!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
             Text(
              "Your Booked Lifts",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20,),
            Consumer<BookingViewModel>(
              builder: (context, model, child) {
                Future<List<Booking>> bookings = model.getBookingsForUser(userId);

                return FutureBuilder(
                    future: bookings,
                    builder: ((context, AsyncSnapshot<List<Booking>> snapshot) {
                      if (snapshot.hasData) {
                        List<Booking> bookings = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                            itemCount: bookings.length,
                            itemBuilder: ((context, index) {
                              Booking booking = bookings[index];
                              return Center(
                                  child: LiftFromBooking(
                                booking: booking,
                              ));
                            }));
                      } else {
                        return Center(
                            child: Text(
                          "Loading Data. Please Wait",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ));
                      }
                    }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LiftFromBooking extends StatelessWidget {
  const LiftFromBooking({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<LiftsViewModel>(builder: ((context, value, child) {
            Future<Lift> lift = value.getLiftFromId(booking.liftId);
            return FutureBuilder(
                future: lift,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    Lift currentlift = snapshot.data!;
                    String destination =
                        "${currentlift.destinationStreet} ${currentlift.destinationTown}";
                    String departure =
                        "${currentlift.departureStreet} ${currentlift.departureTown}";
                    return  LiftCardWithoutButtons(
                      departure: departure,
                      destination: destination,
                      liftId: currentlift.id,
                    );
                  } else {
                    return Center(
                        child: Text(
                      "Loading Data. Please Wait",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ));
                  }
                }));
          }),
        ),
      ],
    );
  }
}
