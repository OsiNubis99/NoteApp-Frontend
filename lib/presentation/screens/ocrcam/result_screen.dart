

import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const SideBar(),
    appBar: AppBar(
      backgroundColor: AppTheme.bgGray,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
      ),
      title: Image.asset(
        "assets/my_notes_app.png",
        width: 130,
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppTheme.text_dark),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.text_dark),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscar Proximamente')));
          },
        ),
      ],
    ),
    body: Container(
      padding: const EdgeInsets.all(30),
      child: Text(text),
    ),
  );
}