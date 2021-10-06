
import 'package:flutter/material.dart';
import 'package:news_flutter_app/constants.dart';

const  Map<int, Color> _color = {
  50:Color(0xFFE9E9FA),
  100:Color(0xFFC7C8F1),
  200:Color(0xFFA2A5E8),
  300:Color(0xFF7C82DF),
  400:Color(0xFF5F65D8),
  500:Color(0xFF4348CF),
  600:Color(0xFF3E3FC4),
  700:Color(0xFF3534B8),
  800:Color(0xFF2C29AC),
  900:Color(0xFF1D0F99),

};

class AppTheme{

  AppTheme._();

  static final MaterialColor primarySwatch = MaterialColor(0xFF4348CF, _color);

  static final ThemeData defaultTheme = ThemeData(
    fontFamily: 'RobotoSlab',
    scaffoldBackgroundColor: kAppBackgroundColor,
    primarySwatch: primarySwatch,
    accentColor: kPrimaryColor,
  );


}