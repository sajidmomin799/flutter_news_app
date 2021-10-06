
import 'package:get_it/get_it.dart';
import 'package:news_flutter_app/providers/article_provider.dart';
import '../app_config.dart';
import 'network_provider.dart';

final getIt = GetIt.instance;

class AppServiceProvider {

  static register() async {
    getIt.registerSingleton<ArticleProvider>(ArticleProvider());
    var networkProvider = NetworkProvider.instance;
    networkProvider.setBaseUrl(AppConfig.baseUrl);
  }
}