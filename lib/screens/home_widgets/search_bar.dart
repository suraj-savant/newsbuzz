import 'package:flutter/material.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/toogle_search_bar.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void searchArticle(String serachInput) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fetching Results for $serachInput')),
      );
      context.read<ArticleProvider>().queryArticles(serachInput);
      context.read<ToogleSearch>().toogleSeachBar();
    }

    const inputDecoration = InputDecoration(
      hintText: "Seach Anything ...",
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
    return AnimatedContainer(
      width: context.watch<ToogleSearch>().isSearchBarActive ? 200 : 0,
      duration: const Duration(seconds: 1),
      child: TextField(
        onSubmitted: searchArticle,
        decoration: inputDecoration,
      ),
    );
  }
}
