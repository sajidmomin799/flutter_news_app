import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_flutter_app/model/articles.dart';
import 'package:news_flutter_app/utils/utils.dart';

import '../constants.dart';
import '../widgets/background_image_widget.dart';

class NewsTile extends StatelessWidget {
  final Article article;
  final Function() onTap;

  const NewsTile({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: getCard(context),
      onTap: onTap,
    );
  }

  Widget getCard(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Stack(
        children: <Widget>[
          BackgroundImageWidget(
            imageUrl: article.urlToImage,
            beginColor: Colors.black38,
            endColor: Colors.black87,
            width: double.infinity,
            height:230,
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              margin: EdgeInsets.all(12),
              child:  Column(
                children: [
                  Text(
                    article.title != null ? article.title! : '',
                    style: TextStyle(
                      color: kTitleTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),

                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        article.source != null && article.source!.name != null ? article.source!.name! : '',
                        style: TextStyle(
                          color: kSubTitleTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        Utils.getFormatedDate(article.publishedAt !=null ? article.publishedAt : '')!,
                        style: TextStyle(
                          color: kSubTitleTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }

}
