class News{
  String? title;
  String? description;
  String? urlToImage;
  String? publishedAt;

  News({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.urlToImage
  });

  factory News.fromJson(Map<String, dynamic> json){

    return News(
      title: json['title'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage']
    );

  }

}