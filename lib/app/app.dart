import 'package:flutter/material.dart';

import 'navigation/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Struct",
      routerConfig: AppRoutes.routes,
    );
  }
}
