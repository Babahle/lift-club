import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/repository/bookings_repository.dart';
import 'package:provider/provider.dart';

import '../services/authentication.dart';

class BookingViewModel extends ChangeNotifier {
  final List<Booking> bookings = [];
  final BookingRepository _bookingRepository = BookingRepository();

  addBookingToDatabase(Booking booking) {
    _bookingRepository.addBookingToCollection(booking);
  }

  deleteBooking(Booking booking) {
    _bookingRepository.deleteBooking(booking);
  }

  Future<Booking> getBookingFromId(String id) async {
    return await _bookingRepository.getBookingFromId(id);
  }

  Future<List<Booking>> getBookingsForUser(String id) {
    return _bookingRepository.getBookingsFromUser(id);
  }

  Future<void> handleBooking(
      BuildContext context, bool booked, Lift? lift, String liftId) async {
    String id =
        Provider.of<AuthenticationService>(context, listen: false).getUserId()!;

    List<Booking> bookings =
        await Provider.of<BookingViewModel>(context, listen: false)
            .getBookingsForUser(id);

    for (Booking booking in bookings) {
      if (booking.ownerId == id && liftId == booking.liftId) {
        booked = true;
      }
    }

    if (lift!.ownerId == id) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You Can't Book A Lift You Created")));
    } else {
      if (lift.seatsAvailable <= 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("This lift is fully booked")));
      } else if (booked) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You've Already Booked This lift")));
      } else {
        Booking createdBooking = lift!.createBooking(id)!;

        Provider.of<BookingViewModel>(context, listen: false)
            .addBookingToDatabase(createdBooking);

        Provider.of<LiftsViewModel>(context, listen: false).updateLift(lift);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("You've Booked This Lift")));
      }
    }

    notifyListeners();
  }

  Future<void> handleBookingCancellation(
      BuildContext context, bool booked, Lift? lift, String liftId) async {
    Booking? removedBooking;

    String id =
        Provider.of<AuthenticationService>(context, listen: false).getUserId()!;

    List<Booking> bookings =
        await Provider.of<BookingViewModel>(context, listen: false)
            .getBookingsForUser(id);

    for (Booking booking in bookings) {
      if (booking.ownerId == id && liftId == booking.liftId) {
        booked = true;
        removedBooking = booking;
      }
    }

    if (lift!.ownerId == id) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Get Serious My Dude!")));
    } else {
      if (booked) {
        lift!.cancelBooking();

        deleteBooking(removedBooking!);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You've Cancelled Your Booking")));

        Provider.of<LiftsViewModel>(context, listen: false).updateLift(lift!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You Haven't Booked This Lift")));
      }
    }

    notifyListeners();
  }
}
