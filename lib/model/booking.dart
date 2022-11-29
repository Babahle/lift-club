import 'package:xid/xid.dart';

class Booking {
  final String id;
  final String ownerId;
  final String liftId;

  Booking({required this.id, required this.ownerId, required this.liftId});

  Booking.fromJson(Map<String, Object?> jsonMap)
      : this(
          ownerId: (jsonMap["ownerId"] as String),
          liftId: (jsonMap["liftId"] as String),
          id: jsonMap["id"] as String,
        );

  Map<String, Object?> toJson() {
    return {'ownerId': ownerId, 'liftId': liftId, 'id': id};
  }
}
