import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final user = FirebaseAuth.instance.currentUser!;
// class GetData{
//    String? receive = '';

//   GetData({this.receive});
Future<String?> getData(String receive) async {
  String? value;

  if (user != null)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((ds) {
      return value = ds.data()!['$receive'];
    }).catchError((e) {
      print(e);
    });
  return value;
}
// }