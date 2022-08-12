import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsbuzz/models/article.dart';
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

  Future<List<Article>> getBookmarks() async {
    final ref =
        await db.collection(FirebaseAuth.instance.currentUser!.uid).get();
    var snapshotData = ref.docs;
    List<Article> temp =
        snapshotData.map((value) => Article.fromJson(value.data())).toList();
    return Future.value(temp);
  }
}
