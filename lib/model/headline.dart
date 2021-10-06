import 'package:news_flutter_app/model/articles.dart';

class Headline {
  String? status;
  int? totalResults;
  List<Article>? articles;

  Headline({this.status, this.totalResults, this.articles});

  Headline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((v) {
        articles!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson(false)).toList();
    }
    return data;
  }
}




