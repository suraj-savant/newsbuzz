import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBuilder extends StatelessWidget {
  const ArticleBuilder({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: ((context, index) {
        Article article = articles[index];
        return ArticleCardWidget(article);
      }),
    );
  }
}

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
        color: Color.fromARGB(255, 249, 249, 251),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 1),
            spreadRadius: 2,
            blurRadius: 4,
          )
        ]);

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageProvider(article.urlToImage ?? 'null'),
          const SizedBox(height: 15),
          ArticleCardHeader(article: article)
        ],
      ),
    );
  }
}

class ArticleCardHeader extends StatefulWidget {
  const ArticleCardHeader({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  State<ArticleCardHeader> createState() => _ArticleCardHeaderState();
}

class _ArticleCardHeaderState extends State<ArticleCardHeader> {
  int? maxTitleLines = 2;

  void changeMaxTitleLines(bool isExpansionIconChanged) {
    int? maxLines = isExpansionIconChanged ? null : 2;
    setState(() {
      maxTitleLines = maxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Article article = widget.article;
    return ExpansionTile(
      textColor: Colors.black,
      maintainState: true,
      onExpansionChanged: (isExpansionIconChanged) =>
          changeMaxTitleLines(isExpansionIconChanged),
      title: Column(
        children: [
          Text(
            article.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: maxTitleLines,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        const SizedBox(height: 5),
        Text(
          "   ${article.description ?? ''}",
          style: const TextStyle(fontSize: 18, color: Colors.black54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(article.url!));
                },
                icon: const Icon(
                  Icons.open_in_new_sharp,
                  size: 30,
                  color: Colors.black54,
                )),
            const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.share,
                  size: 30,
                  color: Colors.black54,
                )),
            const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.bookmark,
                  size: 30,
                  color: Colors.black54,
                )),
          ],
        )
      ],
    );
  }
}

class NetworkImageProvider extends StatelessWidget {
  const NetworkImageProvider(
    this.urlToImg, {
    Key? key,
  }) : super(key: key);

  final String urlToImg;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: (urlToImg != 'null')
          ? Image.network(
              urlToImg,
              height: 200,
              width: double.maxFinite,
              fit: BoxFit.cover,
            )
          : const SizedBox(
              height: 1,
            ),
    );
  }
}
