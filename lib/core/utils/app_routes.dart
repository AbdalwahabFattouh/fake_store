import 'package:fakestoretask/features/auth/presentation/view/auth_view.dart';
import 'package:flutter/cupertino.dart';
import '../../features/auth/presentation/view/pages/register_page.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      auth: (context) => AuthView(),
      register: (context) => RegisterPage(),
    };
  }
}
