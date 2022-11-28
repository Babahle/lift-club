import 'package:lifts_app/model/lift.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xid/xid.dart';

class LiftsRepository {
  var logger = Logger();
  var liftsReference = FirebaseFirestore.instance
      .collection("lifts")
      .withConverter<Lift>(
          fromFirestore: (snapshot, _) => Lift.fromJson(snapshot.data()!),
          toFirestore: (lift, _) => lift.toJson());

  Future<List<Lift>> getAllAvailableLifts() {
    logger.i("Getting All Available Lifts");
    return liftsReference
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList(),
            onError: (e) {
      logger.e("Error trying to get Events $e", e);
    });
  }

  Future<void> addLiftToCollection(Lift lift) async {
    logger.i("Adding ${lift.toJson()} to Firestore database");
    await liftsReference.add(lift);
  }

  //TODO: Create to get a lift based on a ID

  Future<Lift?> getLiftFromId(Xid id) async {
    logger.i("Getting Lift with $id as the id");
    liftsReference.where("id");
    return null;
  }
}
