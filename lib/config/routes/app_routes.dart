import 'package:flutter/material.dart';
import '../../presentation/screens/home/login_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
        'login'      : (BuildContext context) => const LoginScreen(),
      }; 

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LoginScreen(), );
  }
}