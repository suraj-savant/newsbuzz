import 'package:flutter/material.dart';
import 'package:newsbuzz/provider/article_card_header.dart';
import 'package:newsbuzz/screens/bookmarks.dart';
import 'package:newsbuzz/provider/login.dart';
import 'package:provider/provider.dart';

class HomePopUpBtn extends StatelessWidget {
  const HomePopUpBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) => print(value),
        itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
              PopupMenuItem(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<LoginProvider>(context, listen: false)
                          .logOut();
                    },
                    child: Row(
                      children: const [
                        Text("Logout"),
                        Icon(Icons.logout),
                      ],
                    )),
              ),
              PopupMenuItem(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<ArticleCardHeaderProvider>(context,
                              listen: false)
                          .toogleHomeScreen();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BookmarkScreen())).then(
                          (value) => Provider.of<ArticleCardHeaderProvider>(
                                  context,
                                  listen: false)
                              .toogleHomeScreen());
                    },
                    child: Row(
                      children: const [
                        Text("bookmark"),
                        Icon(Icons.bookmark),
                      ],
                    )),
              ),
            ]);
  }
}
