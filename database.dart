//@dart=2.9
import 'package:bloodsquad/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot.data.docs['name'],
  //       sugars: snapshot.data['sugars'],
  //       strength: snapshot.data['strength']);
  // }

  // collection reference
  // final CollectionReference dataCollection =
  //     FirebaseFirestore.instance.collection('users');
  // Stream<UserData> get userData {
  //   return dataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }
}
