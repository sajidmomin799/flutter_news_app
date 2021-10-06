import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:news_flutter_app/page/welcome_page.dart';
import 'package:news_flutter_app/theme/app_theme.dart';

import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(variables: {
    kKeyBaseUrl: 'https://newsapi.org/',
    kKeyAPI: '6e04b6da52684eac9fe99e41086a987b',
  });
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick News',
      theme: AppTheme.defaultTheme,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.defaultTheme,
      home: WelcomePage(),
    );
  }
}
