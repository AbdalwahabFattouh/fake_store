import 'package:fakestoretask/core/services/injection_container.dart' as di;
import 'package:fakestoretask/core/theme/app_theme.dart';
import 'package:fakestoretask/core/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'core/services/isar_db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDBHelper.instance.init();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.auth,
    );
  }
}
