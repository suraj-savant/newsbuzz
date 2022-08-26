import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/provider/article_card_header.dart';
import 'package:newsbuzz/provider/bookmark.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBuilder extends StatelessWidget {
  const ArticleBuilder({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: ListView.builder(
          key: UniqueKey(),
          itemCount: articles.length,
          itemBuilder: ((context, index) {
            Article article = articles[index];
            return ArticleCardWidget(article);
          }),
        ),
      ),
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

class ArticleCardHeader extends StatelessWidget {
  const ArticleCardHeader({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    bool isHomeScreen = context.watch<ArticleCardHeaderProvider>().isHomeScreen;
    IconData bookmarkIcon = Icons.bookmark;

    return ExpansionTile(
      textColor: Colors.black,
      onExpansionChanged: (isExpansionIconChanged) => context
          .read<ArticleCardHeaderProvider>()
          .changeMaxTitleLines(isExpansionIconChanged),
      title: Column(
        children: [
          Text(
            article.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: context.read<ArticleCardHeaderProvider>().maxTitleLines,
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
            IconButton(
                onPressed: () {
                  if (isHomeScreen) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Adding article to bookmark')),
                    );

                    Provider.of<BookmarkProvider>(context, listen: false)
                        .addBookmark(article.toFirestore());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deleting bookmark')),
                    );

                    Provider.of<BookmarkProvider>(context, listen: false)
                        .deleteBookmark(article.title!);
                  }
                },
                icon: Icon(
                  (isHomeScreen) ? bookmarkIcon : Icons.delete,
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
              errorBuilder: (BuildContext context, Object object,
                      StackTrace? stackTrace) =>
                  const SizedBox(
                height: 1,
              ),
            )
          : const SizedBox(
              height: 1,
            ),
    );
  }
}
