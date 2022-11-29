import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:lifts_app/repository/bookings_repository.dart';

class BookingViewModel extends ChangeNotifier {
  final List<Booking> bookings = [];
  final BookingRepository _bookingRepository = BookingRepository();

  addBookingToDatabase(Booking booking) {
    _bookingRepository.addBookingToCollection(booking);
  }

  Future<Booking> getBookingFromId(String id) async {
    return await _bookingRepository.getBookingFromId(id);
  }

  Future<List<Booking>> getBookingsFromUserId(String id) async {
    List<Booking> bookings = [];
    bookings.addAll(await _bookingRepository.getBookingsFromUser(id));
    return bookings;
  }
}
