import 'package:flutter/material.dart';
import '../pages/pages.dart';

class Routes {

  static const String initialRoute = 'home';

  static Map<String, WidgetBuilder> routes = {
    'home': (_) => const HomePage(),
    'details': (_) => const DetailsPage()
  };

}