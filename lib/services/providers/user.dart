import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userProvider = StreamProvider.autoDispose<DocumentSnapshot?>((ref) {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return userRef.snapshots().map((snapshot) => snapshot.exists ? snapshot : null);
  } else {
    return Stream.value(null);
  }
});
