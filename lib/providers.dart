import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userDocumentProvider = StreamProvider.autoDispose<DocumentSnapshot?>((ref) {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return userDocRef.snapshots().map((snapshot) => snapshot.exists ? snapshot : null);
  } else {
    return Stream.value(null);
  }
});