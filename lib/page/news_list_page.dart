import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_flutter_app/constants.dart';
import 'package:news_flutter_app/model/articles.dart';
import 'package:news_flutter_app/page/news_detail_page.dart';
import 'package:news_flutter_app/page/news_tile.dart';
import 'package:news_flutter_app/providers/app_service_provider.dart';
import 'package:news_flutter_app/providers/article_provider.dart';
import 'package:news_flutter_app/widgets/app_loading_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';



class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {

  bool _isLoading = true;
  ArticleProvider? _provider;

  @override
  void initState() {
    super.initState();
    _provider = getIt<ArticleProvider>();
    _fetchArticle();
  }

  _fetchArticle(){
    _provider!.fetch().then((value){
      if(_provider != null && _provider!.articleList.length > 0) {
        setState(() {_isLoading = false;});
      }
    }).onError((error, stackTrace){
      setState(() {_isLoading = false;});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: kAppBarColor,
        title:  Center(
          child: Text(kHeadlines,
            style:
          TextStyle(fontSize: 29, fontWeight: FontWeight.w700,letterSpacing: 4.0),
          ),
        ),
      ),
    body: _getBody()
    );
  }

  Widget _getBody(){

    if(_isLoading){
      return Center(
        child: AppWidgetLoader.innerLoader(),
      );
    }

    if(_provider != null && _provider!.articleList.length == 0){
      return Center(
        child: Text(
          'No Results!',
          style: TextStyle(
            color: kTitleTextColor,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return  ChangeNotifierProvider.value(
      value: getIt<ArticleProvider>(),
      child: Consumer<ArticleProvider>(
        builder: (context, provider, child) {
          return AnimationLimiter(
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:  provider.articleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: SlideAnimation(
                      verticalOffset: 70.0,
                      child: FadeInAnimation(
                        child:  NewsTile(
                          article: provider.articleList[index],
                          onTap: (){
                            _moveToDetailPage(provider.articleList[index]);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  _moveToDetailPage(Article article){
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: NewsDetailPage(article: article),
          inheritTheme: true,
          ctx: context),
    );
  }

  Future<void> _pullRefresh() async {
    _fetchArticle();
  }


}



