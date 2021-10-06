import 'package:flutter/material.dart';
import 'package:news_flutter_app/model/articles.dart';
import 'package:news_flutter_app/widgets/background_image_widget.dart';
import 'package:news_flutter_app/utils/utils.dart';

import '../constants.dart';

class NewsDetailPage extends StatefulWidget {
  final Article article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          child: Image.asset(
            "assets/icon/back_arrow_filled.png",
            height :42,
            width:  42,
            fit: BoxFit.fill,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            BackgroundImageWidget(
              imageUrl: widget.article.urlToImage,
              beginColor: Colors.black54,
              endColor: Colors.black,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        widget.article.title != null
                            ? widget.article.title!
                            : '',
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontSize: 29,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.article.source != null &&
                                      widget.article.source!.name != null
                                  ? widget.article.source!.name!
                                  : '',
                              style: TextStyle(
                                color: kTitleTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.article.publishedAt != null
                                  ? Utils.getFormatedDate(
                                      widget.article.publishedAt)!
                                  : '',
                              style: TextStyle(
                                color: kTitleTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.article.description != null
                            ? widget.article.description!
                            : '',
                        style: TextStyle(
                          color: kSubTitleTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
