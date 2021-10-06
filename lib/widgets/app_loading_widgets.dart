
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class AppWidgetLoader {
  static Widget loader() {
    return SpinKitThreeBounce(
      color: kPrimaryColor,
      size: 30,
    );
  }

  static Widget innerLoader() {
    return SpinKitThreeBounce(
      color: kPrimaryColor,
      size: 30,
    );
  }

}
