import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'core/constants/const.dart';
import 'core/helpers/app_scroll_behavior.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'widgets/global_failure_listener.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GlobalFailureListener(
      child: ToastificationWrapper(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: Const.appName,
            theme: AppTheme.theme,
            routerConfig: AppRoutes.router,
            scrollBehavior: const AppScrollBehavior(),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            builder: (context, child) {
              return Container(
                color: const Color(0xffC7DCFF),
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Center(
                    child: ClipRect(
                      child: child,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
