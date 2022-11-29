import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifts_app/model/booking.dart';
import 'package:logger/logger.dart';

class BookingRepository {
  var logger = Logger();
  var bookingsReference = FirebaseFirestore.instance
      .collection('bookings')
      .withConverter(
          fromFirestore: (snapshot, _) => Booking.fromJson(snapshot.data()!),
          toFirestore: (booking, _) => booking.toJson());

  Future<void> addBookingToCollection(Booking lift) async {
    await bookingsReference.add(lift);
  }

  Future<List<Booking>> getBookingsFromUser(String id) {
    logger.i("Getting Bookings With $id");
    return bookingsReference.where("ownerId", isEqualTo: id).get().then(
        (snapshot) => snapshot.docs.map((data) {
              return data.data();
            }).toList(), onError: (e) {
      logger.e("Error getting bookings $e");
    });
  }

  Future<Booking> getBookingFromId(String id) {
    logger.i("Getting Booking with $id as the id");
    return bookingsReference
        .where("id", isEqualTo: id)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList()[0],
            onError: (e) {
      logger.e("Error trying to get lift $e");
    });
  }
}
