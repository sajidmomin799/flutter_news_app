import 'package:news_flutter_app/model/source.dart';

class Article {
  int? id;
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(
      {this.id,
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  _fromJson(Map<String, dynamic> json,bool forDatabase) {
    if(!forDatabase){
      source =
      json['source'] != null ? new Source.fromJson(json['source']) : null;
    }
    id = json['id'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson(bool forDatabase) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(!forDatabase) {
      if (this.source != null) {
        data['source'] = this.source!.toJson(false);
      }
    }
    data['id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }

  Article.fromJson(dynamic json) {
    _fromJson(json, false);
  }

  Article.fromDBJson(dynamic json) {
    _fromJson(json, true);
  }

  Map<String, dynamic> toDBJson() {
    return toJson(true);
  }
}