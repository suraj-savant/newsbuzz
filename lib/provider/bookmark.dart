import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  String? cureentUserCollection = FirebaseAuth.instance.currentUser?.uid;

  void addBookmark(Map<String, dynamic> article) async {
    await db
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .add(article)
        .then((value) => print("Document Added : ${value.id}"));
  }

  void deleteBookmark(String title) {
    db
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .where("title", isEqualTo: title)
        .get()
        .then((value) => value.docs[0].reference.delete());
  }
}
