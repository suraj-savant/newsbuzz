import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';

class NewsBuilder extends StatelessWidget {
  const NewsBuilder({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: ((context, index) {
        Article article = articles[index];
        return NewsWidget(
            title: article.title!,
            author: article.author!,
            imgSrc: article.urlToImage!);
      }),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key? key,
    required this.title,
    required this.author,
    required this.imgSrc,
  }) : super(key: key);

  final String imgSrc;
  final String title;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 249, 249, 251),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 1),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(imgSrc),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.person),
              Text(author),
            ],
          ),
        ],
      ),
    );
  }
}
