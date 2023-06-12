import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import '../../presentation/screens/login/login_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
        'login'      : (BuildContext context) => const LoginScreen(),
        'home'       : (BuildContext context) => const HomeScreen(),
        'noteList'   : (BuildContext context) => const NoteListScreen(),
      }; 

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LoginScreen(), );
  }
}