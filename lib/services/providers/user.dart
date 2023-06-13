import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/models/user.dart' as edgar;

// final userProvider = StreamProvider.autoDispose<DocumentSnapshot?>((ref) {
//   final User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
//     return userRef.snapshots().map((snapshot) => snapshot.exists ? snapshot : null);
//   } else {
//     return Stream.value(null);
//   }
// });

final userProvider = StreamProvider.autoDispose<edgar.User>((ref) {
  final DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
  final Stream<DocumentSnapshot> snapshotStream = userDocRef.snapshots();
  final Stream<edgar.User> userStream = snapshotStream.asyncMap((snapshot) async {
    final user = await edgar.User.createAsync(snapshot);
    return user;
  });
  return userStream;
});
