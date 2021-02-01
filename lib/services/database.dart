import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gang_brew_crew/models/brew.dart';
import 'package:gang_brew_crew/models/custom_user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({"sugars": sugars, "name": name, "strength": strength});
  }

  // get brew from snapshot
  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      return Brew(
        name: doc.data()["name"] ?? "",
        sugars: doc.data()["sugars"] ?? "0",
        strength: doc.data()["strength"] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()["name"],
        sugars: snapshot.data()["sugars"],
        strength: snapshot.data()["strength"]);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshots);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
