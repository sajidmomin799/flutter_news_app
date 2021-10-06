import 'package:flutter_flavor/flutter_flavor.dart';

import 'constants.dart';

class AppConfig {

  static final String baseUrl = FlavorConfig.instance.variables[kKeyBaseUrl];
  static final String apiKey = FlavorConfig.instance.variables[kKeyAPI];

}
