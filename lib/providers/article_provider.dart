import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:news_flutter_app/app_config.dart';
import 'package:news_flutter_app/manager/database_helper.dart';
import 'package:news_flutter_app/model/articles.dart';
import 'package:news_flutter_app/model/headline.dart';
import 'package:news_flutter_app/model/network_response.dart';
import 'package:news_flutter_app/model/source.dart';
import 'package:news_flutter_app/model/table_enum.dart';
import 'package:news_flutter_app/utils/network_util.dart';
import 'package:news_flutter_app/utils/utils.dart';
import '../api_routes.dart';
import 'network_provider.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articleList = [];

  Future<bool> fetch() async {
    // if (articleList.isNotEmpty) {
    //   notifyListeners();
    //   return true;
    // }

    bool connected = await NetworkUtil().hasConnection();
    if (connected) {
      return fetchFromNetwork();
    } else {
      return fetchFromDatabase();
    }
  }

  Future<bool> fetchFromNetwork() async {
    if (articleList.isNotEmpty) {
      notifyListeners();
      return true;
    }
    final NetworkResponse networkResponse = await NetworkProvider.instance
        .getJSON(routeHeadlines + AppConfig.apiKey);
    if (networkResponse.isSuccess) {
      Headline headlineResponse =
          Headline.fromJson(jsonDecode(networkResponse.response!));
      articleList = headlineResponse.articles!;
      notifyListeners();
      syncArticleData();
      return true;
    }
    return false;
  }

  Future<bool> fetchFromDatabase() async {
    // if (articleList.isNotEmpty) {
    //   notifyListeners();
    //   return true;
    // }

    List<Map<String, dynamic>> articleMapList =
        await DatabaseHelper.getInstance()
            .getMapList(describeEnum(TableEnum.Article));

    List<Map<String, dynamic>> sourceMapList =
        await DatabaseHelper.getInstance()
            .getMapList(describeEnum(TableEnum.Source));

    if (articleMapList != null &&
        sourceMapList != null &&
        articleMapList.isNotEmpty &&
        sourceMapList.isNotEmpty) {
      List<Source> sourceList = [];
      articleList = articleMapList
          .map<Article>((json) => Article.fromDBJson(json))
          .toList();

      sourceList =
          sourceMapList.map<Source>((json) => Source.fromDBJson(json)).toList();
      for (int i = 0; i < articleList.length; i++) {
        if (articleList[i].id == sourceList[i].sourceId) {
          articleList[i].source = sourceList[i];
        }
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> syncArticleData() async {
    try {
      await DatabaseHelper.getInstance().deleteRecords(Utils.getMasterTable());
      if (articleList.isNotEmpty && articleList.length > 0) {
        for (int i = 0; i < articleList.length; i++) {
          int id = await DatabaseHelper.getInstance()
              .insert(describeEnum(TableEnum.Article), articleList[i]);
          articleList[i].source!.sourceId = id;
          await DatabaseHelper.getInstance()
              .insert(describeEnum(TableEnum.Source), articleList[i].source);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
