import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:newsbuzz/utils/widgets/article_builder.dart';
import 'package:newsbuzz/models/article.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookMarks"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return Builder(builder: (context) {
            List<Article> articles = snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  var articleData = document.data()! as Map<String, dynamic>;
                  return Article.fromJson(articleData);
                })
                .toList()
                .cast();
            return ListView.builder(
              key: UniqueKey(),
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  ArticleCardWidget(articles[index]),
            );
          });
        },
      ),
    );
  }
}
