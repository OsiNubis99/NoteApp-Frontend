import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteEditor_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';

import '../../presentation/screens/start/login_screen.dart';
import '../../presentation/screens/start/start_screen.dart';

class AppRoutes {
  static const initialRoute = 'start';

  static Map<String, Widget Function(BuildContext)> routes = {
    'start': (BuildContext context) => const StartScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'noteList': (BuildContext context) => const NoteListScreen(),
    'noteEditor': (BuildContext context) => NoteEditorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );
  }
}
