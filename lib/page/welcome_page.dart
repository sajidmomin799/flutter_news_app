
import 'package:flutter/material.dart';
import 'package:news_flutter_app/page/news_list_page.dart';
import 'package:news_flutter_app/providers/app_service_provider.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    await AppServiceProvider.register();
    await Future.delayed(const Duration(seconds: 2), (){
      moveToDashboard();
    });

  }

  moveToDashboard() async{
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
         NewsListPage()),
        (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:  Image.asset(
            "assets/icon/app_icon.png",
            fit: BoxFit.fill,
            width: 150,
            height: 150,
          ),
        )
    );
  }
}

