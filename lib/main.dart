import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:provider/provider.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';

void main() async {
  // Init HIVE
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(NoteAdapter());

  // Open HIVE boxes for storing data
  await Hive.openBox<Note>(LocalNoteProvider.boxName);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.box(LocalNoteProvider.boxName).compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LocalNoteProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNoteApp',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
