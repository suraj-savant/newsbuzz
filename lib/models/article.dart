import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String? author, title, description, urlToImage, url;

  Article(this.title, this.author, this.description, this.urlToImage);

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        description = json['description'],
        urlToImage = json['urlToImage'],
        url = json['url'];

  @override
  String toString() {
    return '{title : $title, author: $author, description:$description,urlToImage:$urlToImage, url : $url,}';
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "author": author,
      "description": description,
      "urlToImage": urlToImage,
      "url": url,
    };
  }

  factory Article.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Article.fromJson(data!);
  }
}
