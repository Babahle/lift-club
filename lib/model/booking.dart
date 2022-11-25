import 'package:xid/xid.dart';

class Booking {
  final Xid _id = Xid();
  final String ownerId;
  final String liftId;

  Xid get id => _id;

  Booking({required this.ownerId, required this.liftId});

  Booking.fromJson(Map<String, Object?> jsonMap)
      : this(
            ownerId: (jsonMap["ownerId"] as String),
            liftId: (jsonMap["liftId"] as String));

  Map<String, Object?> toJson() {
    return {'ownerId': ownerId, 'liftId': liftId};
  }
}
