import 'package:flutter/material.dart';
import 'package:movies/core.dart';

Map<String, WidgetBuilder> get myRoutes {
  return {
    RoutesName.home: (context) => const HomeView(),
    RoutesName.detailMovie: (context) => const DetailMovie(),
  };
}
