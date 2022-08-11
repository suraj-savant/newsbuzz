import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsbuzz/models/article.dart';

class BookmarkProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  void addBookmark(Map<String, dynamic> article) async {
    await db
        .collection("boomark")
        .add(article)
        .then((value) => print("Document Added : ${value.id}"));
  }

  Future<List<Article>> getBookmarks() async {
    final ref = await db.collection("boomark").get();
    var snapshotData = ref.docs;
    List<Article> temp =
        snapshotData.map((value) => Article.fromJson(value.data())).toList();
    return Future.value(temp);
  }
}
