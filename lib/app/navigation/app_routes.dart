import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodfuckaround/features/auth/presentation/views/login_view.dart';
import '../../features/persons/presentation/views/passenger_details_view.dart';
import '../../features/persons/presentation/views/passengers_view.dart';
import '../data/app_data.dart';
import 'app_middlewares.dart';

class AppRoutes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

  static BuildContext? get rootContext => rootNavigatorKey.currentContext;
  static const home = '/login';

  static final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/passengers', // Default to passengers, middleware will redirect if not logged in
    refreshListenable: AppData.instance, // Listen to token changes
    redirect: AppMiddlewares.authRoutesMiddleware,
    routes: [
      GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: "/passengers",
        name: "passengers",
        builder: (context, state) => const PassengersView(),
        routes: [
           // Nested route for details to allow /passengers/:id
           GoRoute(
            path: ":id",
            name: "passenger_details",
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              return PassengerDetailsView(passengerId: id);
            },
          ),
        ]
      ),
    ],
  );
}
