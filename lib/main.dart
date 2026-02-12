import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Import for web URL strategy
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';
import 'app/data/app_data.dart';
import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Use path URL strategy (no # in URL)
  dependencyInjection();
  await AppData.instance.init();
  runApp(const ProviderScope(child: App()));
}
