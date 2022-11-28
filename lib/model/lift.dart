import 'package:lifts_app/model/booking.dart';
import 'package:xid/xid.dart';

class Lift {
  final DateTime departureDateTime;
  final Xid id;
  final String ownerId;
  final String destinationStreet;
  final String destinationTown;
  final String departureStreet;
  final String departureTown;
  late int seatsAvailable;
  late int numberOfPassengers;

  Booking? createBooking(String passengerId) {
    if (seatsAvailable > 0) {
      numberOfPassengers++;
      seatsAvailable--;
      return Booking(ownerId: passengerId, liftId: id.toString());
    } else {
      return null;
    }
  }

  Lift(
      {required this.departureDateTime,
      required this.id,
      required this.ownerId,
      required this.departureStreet,
      required this.departureTown,
      required this.destinationStreet,
      required this.destinationTown,
      required this.numberOfPassengers,
      required this.seatsAvailable});

  Lift.fromJson(Map<String, Object?> jsonMap)
      : this(
            departureDateTime:
                DateTime.parse(jsonMap['departureDateTime'] as String),
            id: Xid.fromString(jsonMap['ownerId'] as String),
            ownerId: jsonMap['ownerId'] as String,
            departureStreet: jsonMap['departureStreet'] as String,
            departureTown: jsonMap['departureTown'] as String,
            destinationStreet: jsonMap['destinationStreet'] as String,
            destinationTown: jsonMap['destinationTown'] as String,
            numberOfPassengers: jsonMap['numberOfPassengers'] as int,
            seatsAvailable: jsonMap['seatsAvailable'] as int);

  Map<String, Object?> toJson() {
    return {
      'departureDateTime': departureDateTime.toIso8601String(),
      'id': id.toString(),
      'ownerId': ownerId,
      'departureStreet': departureStreet,
      'departureTown': departureTown,
      'destinationStreet': destinationStreet,
      'destinationTown': destinationTown,
      'numberOfPassengers': numberOfPassengers,
      'seatsAvailable': seatsAvailable
    };
  }

  @override
  String toString() {
    return 'Lift{departureDateTime: $departureDateTime, ownerId: $ownerId, destinationStreet: $destinationStreet, destinationTown: $destinationTown, departureStreet: $departureStreet, departureTown: $departureTown, seatsAvailable: $seatsAvailable, numberOfPassengers: $numberOfPassengers}';
  }
}
