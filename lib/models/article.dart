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
    return '{title : $title, author: $author, description:$description, url : $url}';
  }
}
